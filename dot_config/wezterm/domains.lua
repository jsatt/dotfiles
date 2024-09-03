local wezterm = require("wezterm")

local M = {}

local function docker_list()
  local docker_list = {}
  local success, stdout, stderr = wezterm.run_child_process {
    '/usr/local/bin/docker',
    'container',
    'ls',
    '--format',
    '{{.ID}}:{{.Names}}',
  }
  for _, line in ipairs(wezterm.split_by_newlines(stdout)) do
    local id, name = line:match '(.-):(.+)'
    if id and name then
      docker_list[id] = name
    end
  end
  return docker_list
end

local function make_docker_label_func(id)
  return function(name)
    local success, stdout, stderr = wezterm.run_child_process {
      '/usr/local/bin/docker',
      'inspect',
      '--format',
      '{{.State.Running}}',
      id,
    }
    local running = stdout == 'true\n'
    local color = running and 'Green' or 'Red'
    return wezterm.format {
      { Foreground = { AnsiColor = color } },
      { Text = 'docker container named ' .. name },
    }
  end
end

local function make_docker_fixup_func(id)
  return function(cmd)
    cmd.args = cmd.args or { '/bin/zsh' }
    local wrapped = {
      '/usr/local/bin/docker',
      'exec',
      '-it',
      '-e',
      'TERM=xterm-256color',
      id,
    }
    for _, arg in ipairs(cmd.args) do
      table.insert(wrapped, arg)
    end

    cmd.args = wrapped
    return cmd
  end
end

function M.compute_exec_domains()
  local exec_domains = {}
  for id, name in pairs(docker_list()) do
    table.insert(
      exec_domains,
      wezterm.exec_domain(
        'docker:' .. name,
        make_docker_fixup_func(id),
        make_docker_label_func(id)
      )
    )
  end
  return exec_domains
end

function M.select_domain(preferred, fallback, exec_domains)
  for _, domain in ipairs(exec_domains) do
    if domain['name'] == preferred then
      return preferred
    end
  end
  return fallback
end

return M

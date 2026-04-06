local wezterm = require("wezterm")

local M = {}


local docker_path = ''

local function find_docker_exec()
  local docker_paths = {
    '/usr/local/bin/docker',
    '/usr/bin/docker',
  }
  for _, path in ipairs(docker_paths) do
    local success, stdout, stderr = wezterm.run_child_process { path, 'version' }
    if success then
      return path
    end
  end
end


local function docker_list()
  local containers = {}
  local docker_exec = find_docker_exec()
  if docker_exec then
    local success, stdout, stderr = wezterm.run_child_process {
      docker_exec,
      'container',
      'ls',
      '--format',
      '{{.ID}}:{{.Names}}',
    }
    for _, line in ipairs(wezterm.split_by_newlines(stdout)) do
      local id, name = line:match '(.-):(.+)'
      if id and name then
        containers[id] = name
      end
    end
    print('---', containers)
    return containers
  end
end

local function make_docker_label_func(id)
  return function(name)
    local docker_exec = find_docker_exec()
    if docker_exec then
      local success, stdout, stderr = wezterm.run_child_process {
        docker_exec,
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
end

local function make_docker_fixup_func(id)
  return function(cmd)
    local docker_exec = find_docker_exec()
    if docker_exec then
      cmd.args = cmd.args or { '/bin/zsh' }
      local wrapped = {
        docker_exec,
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

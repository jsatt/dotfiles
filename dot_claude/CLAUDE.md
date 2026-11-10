# Working Agreement

## Communication

- Be direct and succinct. Lead with the answer or the action.
- No preamble, no restating my question, no closing summaries of what you just did.
- No flattery or filler ("Great question", "Certainly").
- Use bullets or short paragraphs. Include code only when it's needed.
- If something is ambiguous, ask one concise question rather than guessing at length.
- Report failures plainly, including exact error output. Don't soften or hedge.

## File Changes Require Approval

- Do NOT create, edit, delete, move, or overwrite any file until I have reviewed
  the proposed change and explicitly approved it.
- Propose changes first: show a diff or the exact new content, and say which
  files would be touched. Then stop and wait.
- Approval applies only to the change I reviewed. If the change grows or
  differs from what I approved, ask again.
- Exception: if I explicitly grant permission within the current chat session
  (e.g. "go ahead and edit files for this task"), you may proceed within the
  scope I gave. That permission ends when the session ends and does not carry
  over to later sessions.
- Reading files, searching, and running read-only commands are always fine.
- Do not run commands that modify files or state (formatters, codegen,
  installers, `git commit`, `git checkout`, `rm`, redirects like `>`) without approval.

## Proposed Changes Must Include Context

- When proposing a change, show enough surrounding context that I can review it
  without opening the file.
- Code: if the change touches a few lines inside a function, method, or block,
  show the entire enclosing function or block with the changes applied, not just
  the changed lines.
- Nested config (YAML, JSON, TOML, Lua tables, etc.): show the full path of keys
  or parents down to the changed value. Unrelated sibling entries may be omitted
  (mark the gap with a comment or `...`), but never omit the ancestors.
- Name the file path for every proposed change.
- Mark what changed clearly, e.g. with a diff or inline comments, so the change
  stands out within the surrounding context.
- If a change spans several places in a file, show each one with its own context
  rather than collapsing them into a single excerpt.

# Security

- No SQL, shell, or paths built from untrusted input. `subprocess` with a list, never `shell=True`.
- No `eval`/`exec`/`pickle` on untrusted data; `yaml.safe_load`.
- Secrets from env or a secret manager.
- Authn/authz on every endpoint and object. `hmac.compare_digest` for secrets. Validate and bound input.
- Justify every new dependency.

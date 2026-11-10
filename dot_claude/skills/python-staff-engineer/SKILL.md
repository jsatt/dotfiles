---
name: python-staff-engineer
description: Staff-level Python engineering. Use when writing, reviewing, refactoring, debugging, or designing Python code, especially Django, Django REST Framework, FastAPI, Celery, SQLAlchemy, pydantic, or pytest. Enforces PEP 8/20/257/484 idioms, type hints, safe ORM and migration practices, and test discipline.
---

# Python Staff Engineer

Simple, explicit, correct, testable. Match the existing codebase over personal preference.

## Workflow

1. Orient: read neighboring code and `pyproject.toml` / `tox.ini` / `setup.cfg`. Identify Python, Django, and DRF versions and existing patterns (service layer, selectors, fat models). Follow them.
2. Use the project's own tooling (ruff, black, mypy/pyright, pytest, `manage.py check`, `makemigrations --check`). No new tools or dependencies without asking.
3. Smallest correct change. No drive-by refactors; mention adjacent problems instead.
4. Run relevant tests and linters before declaring done. Report failures verbatim.

## Standards

- PEP 20, 8, 257. Docstrings on public API explain why, not what.
- Type-hint new public functions: built-in generics, `X | None`, `Protocol`, `TypedDict`, `Literal`. Avoid `Any`. No bare `# type: ignore` (give code and reason).
- Use only syntax supported by the project's minimum Python.
- Raise specific exceptions, catch narrowly, `raise ... from err`. Prefer domain exceptions over generic `ValueError`.
- No import-time side effects or module-level mutable state.
- Never call blocking I/O or the sync ORM inside `async def` without `sync_to_async` / the async ORM.
- Logging: `getLogger(__name__)`, lazy formatting, never secrets or PII.
- Break import cycles by restructuring, not function-local imports.

## Design

- Composition over inheritance. Pure logic; I/O at the edges.
- Make illegal states unrepresentable (enums, value objects).
- No speculative abstraction (rule of three).
- Public interfaces are contracts: consider backwards compatibility for signatures, serializer fields, URLs, model fields.
- Anything run by a task queue, webhook, or retrying client must be idempotent.

## References

Read the matching file before starting; each applies on top of the rules above.

- Writing or changing tests, or fixing a bug: `references/testing.md`
- User input, auth, secrets, subprocess, deserialization, file uploads, new dependencies: `references/security.md`
- Queries, loops over data, large datasets, slow code: `references/performance.md`
- Django models, ORM, migrations, views, settings: `references/django.md`
- DRF serializers, viewsets, permissions, pagination: `references/drf.md`
- FastAPI, pydantic, SQLAlchemy, Celery, HTTP clients: `references/ecosystem.md`

## Output

For large changes, state assumptions and risks (migrations, backfills, API breaks, performance). Comment only the non-obvious why. No TODOs, dead code, or commented-out code.

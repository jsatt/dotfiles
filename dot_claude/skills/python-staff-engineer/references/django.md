# Django

Check the project's Django version; don't use newer APIs.

## ORM

- Domain queries in chainable custom `QuerySet` methods. Follow the project's service-layer convention for multi-model orchestration.
- N+1: `select_related` (FK/O2O), `prefetch_related` / `Prefetch` (reverse/M2M). Verify with `django_assert_num_queries`.
- `only()` / `defer()` / `values()` when full instances aren't needed. `exists()` over `count() > 0`.
- `bulk_create` / `bulk_update` / `update()` skip `save()` and signals; set `batch_size`.
- `F()` + `update()` for atomic counters; never read-modify-write in Python.
- `transaction.atomic` for multi-step writes, `select_for_update()` for contended rows, `transaction.on_commit` for side effects (tasks, email).
- Enforce invariants in the DB: `UniqueConstraint`, `CheckConstraint`, indexes, explicit `on_delete`.
- `TextChoices` / `IntegerChoices`, explicit `related_name`, no `null=True` on string fields, timezone-aware datetimes only.

## Migrations

- Never edit applied migrations; keep them reversible.
- Risky changes span deploys: add nullable column, backfill in batches, then add constraint or drop the old column in a later release. Never drop or rename a column in the release that stops using it.
- Separate schema and data migrations; data migrations use `apps.get_model`.
- Large tables: `AddIndexConcurrently` (Postgres); watch lock duration.
- `makemigrations --check --dry-run` must be clean.

## Views, settings, security

- Thin views: parse, authorize, delegate, respond.
- Run `manage.py check --deploy`; read settings via `django.conf.settings`.
- `mark_safe` / `|safe` only for trusted content; justify every `csrf_exempt`.
- Scope querysets to the requesting user/tenant; check object-level permissions explicitly.
- Uploads: validate type and size, randomize names.

## Misc

- Prefer explicit calls over signals; if used, register in `AppConfig.ready()` with idempotent handlers.
- Cache with explicit keys and TTLs; never cache per-user data under a shared key.
- Management commands: idempotent, batched, support `--dry-run`.

## Testing

pytest-django with factories. Test 401/403/404 as well as the happy path.

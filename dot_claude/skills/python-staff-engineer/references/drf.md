# Django REST Framework

## Serializers

- Explicit `fields`; never `"__all__"` or `exclude` on writable public APIs.
- Separate read and write serializers when shapes differ.
- `validate_<field>` / `validate` for validation; business rules live in the model or service layer.
- `read_only_fields` / `extra_kwargs` to block mass assignment.
- No per-row queries in `SerializerMethodField`; annotate or prefetch in `get_queryset`.
- Nested writes: explicit `create` / `update` inside `transaction.atomic`.

## Views

- Narrowest base class that works; `ModelViewSet` only for full CRUD.
- Always override `get_queryset`: scope by user/tenant and add `select_related` / `prefetch_related`. A class-level `queryset` is not authorization.
- `get_serializer_class` per action; `@action` with explicit `permission_classes`; `perform_create` to inject request context.

## Permissions and throttling

- Restrictive global default (`IsAuthenticated`); loosen per view. `has_object_permission` only runs via `get_object()`.
- Throttle login, password reset, and exports.

## Pagination and filtering

- Always paginate; cursor pagination for large or changing data; cap `max_page_size`.
- `django-filter` `FilterSet`s; whitelist `ordering_fields`.

## Errors and contracts

- Raise DRF exceptions; one error envelope via a custom exception handler; correct status codes.
- Version the API; additive changes only within a version; keep drf-spectacular generation warning-free.

## Testing

`APIClient` + `force_authenticate`: unauthenticated, forbidden, other-tenant object (404), validation errors, pagination, query count.

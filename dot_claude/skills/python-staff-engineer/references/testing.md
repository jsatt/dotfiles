# Testing

- pytest (+ pytest-django) unless the project uses unittest. Test behavior, not implementation.
- Real DB and factories; mock only at boundaries (network, clock, third parties).
- Every bug fix gets a regression test that fails first.
- Parametrize; keep tests deterministic; assert query counts on hot paths.

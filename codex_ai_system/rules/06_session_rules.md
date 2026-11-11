# Session ownership

- Register one SessionManager per app. Await initialize before constructing headers
  or running the app.
- SessionReader is the read contract for networking/features: current, changes,
  cacheScope. It contains no Flutter, Dio, Hive, or Cubit dependencies.
- SessionManager owns the current in-memory session. SessionStore controls optional
  persistence; SecureSessionStore is production storage, InMemorySessionStore is a
  test/demo implementation.
- TokenCubit adapts session changes for UI and may be disposed without ending the
  app session. API headers never depend on TokenCubit.
- rememberMe=false removes previously persisted credentials.
- Serialize restoration, sign-in, and sign-out to avoid late restoration overwriting
  a newer user action. A failed storage operation must not poison future operations.
- Logout revokes in-memory access, rotates the scope, and clears feature caches.
  Persistent deletion errors are surfaced to the caller.
- Cache cleanup is best effort: rotated scopes keep old entries inaccessible even
  when physical deletion fails. Cache failures must not block authentication.
- Keep FCM/device registration separate from the shared session contract.
- Do not persist credentials in HydratedCubit state or Hive caches.

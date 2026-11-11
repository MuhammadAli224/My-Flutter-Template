# State management

- Use Cubit and Freezed union/sealed states for feature request flows.
- States contain entities, never DTOs or API envelopes.
- Cubits call use cases, not APIs/datasources.
- Use CubitLifecycleMixin.beginRequest for each asynchronous operation key.
- After awaiting, check isCurrentRequest before emitting; finishRequest in finally.
  This makes the latest request win and cancels obsolete transport work.
- Closing a Cubit cancels requests/timers. Ignore calls made after close.
- Errors must reach a terminal error state; never leave result handling commented out.
- Application services own shared session state. Route-scoped Cubits are factories
  owned/disposed by BlocProvider. Do not hand a GetIt singleton Cubit to a provider
  that closes it.
- Do not blindly retry writes or cancellations. Add retries only for a documented,
  idempotent operation.
- Synchronous settings state may use a focused immutable value type; do not force
  network loading/error unions onto simple local preferences.

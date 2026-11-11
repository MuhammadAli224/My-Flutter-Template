# Review prompt

```md
Follow AGENTS.md and the canonical rules in codex_ai_system/rules/.

Review [files/feature] without changing files.

Prioritize correctness and user impact: shared session ownership, restoration and
request races, cache scope/expiry, cancellation, loading/error behavior, domain
boundaries, DI disposal, localization, and generator consistency.

Report findings by severity with file/line evidence, concrete failure scenarios,
and recommended fixes. Distinguish verified findings from assumptions.
```

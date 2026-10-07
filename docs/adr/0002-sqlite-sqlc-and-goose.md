# ADR 0002: SQLite, sqlc, and Goose persistence

- Status: Accepted
- Date: 2026-10-07

## Context

The initial application has one owner, no distributed write workload, and should run locally without infrastructure services. The data layer should remain explicit and testable while leaving a reasonable path to PostgreSQL if deployment requirements change.

## Decision

Use SQLite through `database/sql` with the pure-Go `modernc.org/sqlite` driver. Define data access as SQL and generate typed Go code with sqlc. Manage ordered SQL migrations with Goose.

Keep application transactions and SQL semantics visible. Enable SQLite foreign-key enforcement and use database constraints for invariants that can be expressed reliably. Treat migrations merged to `main` as immutable and add corrective migrations instead of editing history.

## Consequences

Local development and low-cost hosting need no database service. SQL remains portable in principle, but SQLite-specific behavior must be isolated and a future PostgreSQL move would still require deliberate migration work. Generated sqlc output must remain synchronized with migrations and queries.

# ADR 0001: Server-rendered Go monolith

- Status: Accepted
- Date: 2026-10-07

## Context

EARR is initially a personal project, should remain inexpensive to run, and includes content-oriented pages that benefit from directly rendered HTML. A separate browser application and JSON API would increase build, deployment, and maintenance complexity without a current requirement.

## Decision

Use a modular Go monolith. Render pages with the standard Go HTML template system, use HTMX for progressively enhanced interactions, and use plain CSS organized around design tokens. Keep domain, persistence, content, nutrition, and web concerns behind separate internal package boundaries.

Do not introduce a single-page application or require client-side JavaScript for core reading flows. Add JSON endpoints only for an identified use case rather than treating them as the primary application boundary.

## Consequences

The application can ship as one binary and one container image. Pages remain indexable and functional with limited JavaScript. Highly interactive features may require revisiting this decision, but HTMX and isolated browser components can cover incremental needs first.

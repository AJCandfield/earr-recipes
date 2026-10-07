# ADR 0004: Domain and publication constraints

- Status: Accepted
- Date: 2026-10-07

## Context

Recipes need reflux-conscious and eventual traditional variants, ordered ingredients and steps, searchable tags, metric reporting, and ingredient-level nutrition. The initial application has no authentication layer but may later be hosted publicly.

## Decision

Use the model in `docs/diagrams/recipe-data-model.mmd` as the initial domain boundary. A recipe owns one or more versions and exactly one version is the default. The initial default is anti-reflux. Preserve ingredient and nutrition values on the recipe version so published calculations remain reproducible.

Represent weight, volume, quantities, calories, and macronutrients with fixed-point values rather than binary floating-point numbers. Use metric units for weight and volume, allowing teaspoons and tablespoons only for small non-influential quantities. Derive totals and per-serving nutrition from ingredient-level values instead of storing competing totals as independent sources of truth.

Until authentication and authorization exist, authoring is local-only and a public deployment exposes no mutation endpoints.

## Consequences

The storage schema must enforce default-version and ordering invariants. Nutrition data is a reproducible snapshot rather than a live external reference. Public hosting can begin safely as read-only, while browser-based authoring remains blocked on an explicit security design.

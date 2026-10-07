# ADR 0003: Versioned Markdown and web assets

- Status: Accepted
- Date: 2026-10-07

## Context

Educational pages should be easy to review and version without building a content management system. Browser dependencies should be reproducible and should not require a runtime content-delivery network or a Node-based build pipeline.

## Decision

Store educational content as Markdown in `content`. Keep templates, CSS, and browser assets in the repository. Vendor a pinned HTMX distribution with its license and checksum. Serve these assets from the application and design the eventual response policy around a restrictive Content Security Policy.

Do not introduce a JavaScript package manager until a concrete frontend requirement justifies it.

## Consequences

Content and dependency changes are visible in Git, local development works offline, and production does not depend on a CDN. Vendored browser dependency updates require checksum and license verification in addition to normal dependency review.

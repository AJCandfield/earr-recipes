# Agent guidelines

- Read `README.md`, the relevant ADRs, and the domain diagram before changing architecture or data boundaries.
- Keep changes focused; do not add product behavior, dependencies, or abstractions without a demonstrated need.
- Use metric weight and volume units except for small measures such as teaspoons and tablespoons.
- Never use binary floating-point values for quantities, calories, or macronutrients.
- Make schema changes through Goose migrations and keep sqlc output synchronized; do not rewrite migrations already merged to `main`.
- Do not expose unauthenticated write operations in a public deployment.
- Run `just check` and `pre-commit run --all-files` before requesting review.

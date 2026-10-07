set shell := ["bash", "-euo", "pipefail", "-c"]

default: check

bootstrap:
    mise install
    pre-commit install

fmt:
    files="$(find . -type f -name '*.go' -not -path './vendor/*')"; if [[ -n "$files" ]]; then gofmt -w $files; fi

fmt-check:
    files="$(find . -type f -name '*.go' -not -path './vendor/*')"; if [[ -n "$files" ]]; then test -z "$(gofmt -l $files)"; fi

vet:
    go vet ./...

test:
    go test -coverprofile=coverage.out ./...

lint:
    golangci-lint run ./...

vuln:
    govulncheck ./...

migrations-check:
    if find db/migrations -type f -name '*.sql' -print -quit | grep -q .; then goose -dir db/migrations validate; fi

sqlc-generate:
    if find db/queries -type f -name '*.sql' -print -quit | grep -q .; then sqlc generate; fi

sqlc-check:
    if find db/queries -type f -name '*.sql' -print -quit | grep -q .; then sqlc generate; test -z "$(git status --porcelain --untracked-files=all -- internal/store/db)"; fi

lint-config:
    actionlint
    hadolint Dockerfile

assets-check:
    cd web/static/vendor/htmx && if command -v sha256sum >/dev/null 2>&1; then sha256sum --check SHA256SUMS; else shasum -a 256 --check SHA256SUMS; fi

build:
    mkdir -p bin
    go build -trimpath -o bin/earr-server ./cmd/server

docker-build:
    docker build --tag earr-recipes:local .

dev:
    go run ./cmd/server

check: fmt-check vet test lint vuln migrations-check sqlc-check lint-config assets-check build

ci: check

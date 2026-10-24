FROM golang:1.27.1-bookworm@sha256:8d48e12ec56735e9358640898b9d9b9fcca110612ed8a5567438c0a1baa24e66 AS build

WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY internal/ ./internal/
COPY cmd/ ./cmd/
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/earr-server ./cmd/server \
    && mkdir -p /out/data \
    && chown 65532:65532 /out/data

FROM gcr.io/distroless/static-debian13:nonroot@sha256:18f4cc26c9ffa7f20a359298be7deadac5c607c8e03a02b8119f1a5fc2f82c99

WORKDIR /app
COPY --from=build --chown=65532:65532 /out/earr-server /app/earr-server
COPY --from=build --chown=65532:65532 /out/data /data
VOLUME ["/data"]
ENV EARR_DATABASE_PATH=/data/earr.db
EXPOSE 8080
USER 65532:65532
ENTRYPOINT ["/app/earr-server"]

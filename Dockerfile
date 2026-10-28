FROM golang:1.27.3-bookworm@sha256:d9b6a1beb9474adc2a1ce842573639b44b2a0dd49b6669f51d3821baf9ec37c9 AS build

WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY internal/ ./internal/
COPY cmd/ ./cmd/
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/earr-server ./cmd/server \
    && mkdir -p /out/data \
    && chown 65532:65532 /out/data

FROM gcr.io/distroless/static-debian13:nonroot@sha256:e2e927ec666bae08560abb3c55d0659eceabb657f56b6782ab500a9fc7f555e3

WORKDIR /app
COPY --from=build --chown=65532:65532 /out/earr-server /app/earr-server
COPY --from=build --chown=65532:65532 /out/data /data
VOLUME ["/data"]
ENV EARR_DATABASE_PATH=/data/earr.db
EXPOSE 8080
USER 65532:65532
ENTRYPOINT ["/app/earr-server"]

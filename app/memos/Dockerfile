#Building the frontend
FROM node:24-alpine@sha256:8a32c8cf649a49915a66e81e7a609223c708d0adabf288ee3f4077d765542f85 AS frontend-builder

WORKDIR /app/memos

RUN corepack enable 

COPY web/package.json web/pnpm-lock.yaml web/pnpm-workspace.yaml ./web/
COPY web/patches/ ./web/patches/

WORKDIR /app/memos/web

RUN pnpm install --frozen-lockfile

COPY web/ .

RUN pnpm run release


#Building the backend
FROM golang:1.27@sha256:e519d3b0a5b285e5aa53ab9eef02bc6bbb9cb04608389b743a136a9ce75f0d1e AS backend-builder
WORKDIR /app/memos

COPY go.mod go.sum ./

RUN go mod download

COPY . ./

#copy files from frontend-builder stage into backend-builder stage but same path as in frontend-builder stage as go build command will look for static files in the same path as in frontend-builder stage
COPY --from=frontend-builder /app/memos/server/frontend/dist ./server/frontend/dist

ARG VERSION
ARG COMMIT=unknown

RUN CGO_ENABLED=0 go build \
    -ldflags="-X github.com/usememos/memos/internal/version.Version=${VERSION} -X github.com/usememos/memos/internal/version.Commit=${COMMIT}" \
    -o main ./cmd/memos

#Build the final runtime image
FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS final

RUN apk add --no-cache ca-certificates

WORKDIR /app/memos

COPY --from=backend-builder /app/memos/main ./main

RUN addgroup -S memos && \
    adduser -S -G memos memos && \
    mkdir -p /var/opt/memos && \
    chown -R memos:memos /var/opt/memos

ENV MEMOS_DATA=/var/opt/memos

USER memos

EXPOSE 8081

CMD ["./main"]
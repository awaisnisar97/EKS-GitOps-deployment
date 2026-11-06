#Building the frontend
FROM node:24-alpine@sha256:8a32c8cf649a49915a66e81e7a609223c708d0adabf288ee3f4077d765542f85 AS frontend-builder

WORKDIR /app/memos

RUN corepack enable 

COPY web/package.json web/pnpm-lock.yaml ./web/

WORKDIR /app/memos/web

RUN pnpm install --frozen-lockfile

COPY web/ .

RUN pnpm run release


#Building the backend
FROM golang:1.27 AS backend-builder

WORKDIR /app/memos

COPY go.mod go.sum ./

RUN go mod download

COPY . ./

#copy files from frontend-builder stage into backend-builder stage but same path as in frontend-builder stage as go build command will look for static files in the same path as in frontend-builder stage
COPY --from=frontend-builder /app/memos/server/frontend/dist ./server/frontend/dist
RUN go build -o main ./cmd/memos

#Build the final runtime image
FROM alpine:3.24 AS final

WORKDIR /app/memos

COPY --from=backend-builder /app/memos/main ./main

RUN addgroup -S memos && adduser -S -G memos memos

USER memos

EXPOSE 8081

CMD ["./main"]
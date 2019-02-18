FROM golang:1.11-alpine as build
RUN apk add --no-cache git ca-certificates tzdata
RUN adduser -D appuser
WORKDIR /app
COPY . /app/
RUN CGO_ENABLED=0 go build -o app .
USER appuser
CMD ./app

FROM scratch as release
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /etc/passwd /etc/group /etc/
WORKDIR /app
COPY --from=build /app/app /app/app
USER appuser
CMD [ "./app" ]

FROM golang:1.11-alpine as build
WORKDIR /app
RUN adduser -D appuser
COPY . /app/
RUN CGO_ENABLED=0 go build -o app .
USER appuser
CMD ./app

FROM scratch as release
WORKDIR /app
COPY --from=build /app/app /app/app
USER appuser
CMD [ "./app" ]

FROM golang:latest
WORKDIR /app
COPY . /app/
CMD go run main.go

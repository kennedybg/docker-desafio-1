FROM golang:1.16-alpine AS stage-1

WORKDIR /go/src/app
COPY . .

RUN go mod init
RUN go get -d -v ./...
RUN go install -v ./...
RUN go build -v

FROM scratch

WORKDIR /app

COPY --from=stage-1 /go/src/app/app .

ENTRYPOINT [ "./app" ]

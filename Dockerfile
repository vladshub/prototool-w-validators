FROM golang:1.12.4-alpine3.9 as builder

RUN apk add --update --no-cache build-base curl git upx && \
  rm -rf /var/cache/apk/*

RUN GO111MODULE=on go get \
  github.com/mwitkow/go-proto-validators/protoc-gen-govalidators && \
  mv /go/bin/protoc-gen-go* /usr/local/bin/

RUN upx --lzma /usr/local/bin/*

FROM uber/prototool

COPY --from=builder /usr/local/bin/protoc-gen-go* /usr/local/bin/





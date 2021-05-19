FROM golang:alpine as builder

ARG REGVER=0.16.1

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN	apk add --no-cache \
    git \
	bash \
	wget \ 
	unzip \
	ca-certificates

RUN wget https://github.com/genuinetools/reg/archive/refs/tags/v${REGVER}.zip \
 && unzip v${REGVER}.zip \
 && mkdir -p /go/src/github.com/genuinetools/ \
 && mv reg-${REGVER} /go/src/github.com/genuinetools/reg

RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		git \
		gcc \
		libc-dev \
		libgcc \
		make \
	&& cd /go/src/github.com/genuinetools/reg \
	&& make static \
	&& mv reg /usr/bin/reg \
	&& apk del .build-deps \
	&& rm -rf /go \
	&& echo "Build complete."

FROM alpine:latest

COPY --from=builder /usr/bin/reg /usr/bin/reg
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs

WORKDIR /src

ENTRYPOINT [ "reg" ]
CMD [ "--help" ]

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="nathanvaughn/reg" \
      org.label-schema.description="Docker image for reg" \
      org.label-schema.license="MIT" \
      org.label-schema.url="https://github.com/nathanvaughn/reg-docker" \
      org.label-schema.vendor="nathanvaughn" \
      org.label-schema.version=$REGVER \
      org.label-schema.vcs-url="https://github.com/nathanvaughn/reg-docker.git" \
      org.label-schema.vcs-type="Git" \
      org.opencontainers.image.title="nathanvaughn/reg" \
      org.opencontainers.image.description="Docker image for reg" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.url="https://github.com/nathanvaughn/reg-docker" \
      org.opencontainers.image.authors="Nathan Vaughn" \
      org.opencontainers.image.vendor="nathanvaughn" \
      org.opencontainers.image.version=$REGVER \
      org.opencontainers.image.source="https://github.com/nathanvaughn/reg-docker.git"
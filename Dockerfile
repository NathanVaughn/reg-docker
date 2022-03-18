FROM docker.io/library/golang:alpine as builder

ARG REGVER

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

FROM docker.io/library/golang:alpine:latest

COPY --from=builder /usr/bin/reg /usr/bin/reg
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs

WORKDIR /src

ENTRYPOINT [ "reg" ]
CMD [ "--help" ]

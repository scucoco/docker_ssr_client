FROM alpine
MAINTAINER kukuqiu5 <qm2009@gmail.com>

RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD aes-256-cfb
ENV PROTOCOL origin
ENV TIMEOUT 300
ENV OBFS plain

ENTRYPOINT ["/usr/bin/sslocal"]
CMD ssserver -s "$SERVER_ADDR" \
             -p "$SERVER_PORT" \
             -m "$METHOD"      \
             -k "$PASSWORD"    \
             -t "$TIMEOUT"     \
             -O "$PROTOCOL"    \
             -o "$OBFS"        \
             --fast-open $OPTIONS

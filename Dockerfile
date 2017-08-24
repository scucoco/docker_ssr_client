FROM alpine
MAINTAINER kukuqiu5 <qm2009@gmail.com>

RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr-backup/shadowsocksr/archive/3.1.2.zip

ENV SERVER_ADDR 35.187.145.215
ENV SERVER_PORT 18989
ENV PASSWORD 
ENV LOCAL 127.0.0.1
ENV LOCAL_PORT 1080
ENV METHOD aes-256-cfb
ENV PROTOCOL origin
ENV TIMEOUT 300
ENV OBFS plain

ENTRYPOINT ["/usr/bin/sslocal"]
CMD sslocal -s "$SERVER_ADDR" \
             -p "$SERVER_PORT" \
             -m "$METHOD"      \
             -k "$PASSWORD"    \
             -t "$TIMEOUT"     \
             -O "$PROTOCOL"    \
             -o "$OBFS"        \
             --fast-open $OPTIONS

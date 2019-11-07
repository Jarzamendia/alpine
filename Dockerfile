FROM alpine:3.10

ENV LANG=pt_BR.UTF-8

RUN apk add --no-cache ca-certificates libressl wget && \
    wget "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" -O "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk" \
         "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk" \
         "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-i18n-2.30-r0.apk" && \
    apk add --no-cache \
        "glibc-2.30-r0.apk" \
        "glibc-bin-2.30-r0.apk" \
        "glibc-i18n-2.30-r0.apk" && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" \
       "glibc-2.30-r0.apk" \
       "glibc-bin-2.30-r0.apk" \
       "glibc-i18n-2.30-r0.apk" \
       "/root/.wget-hsts" && \
    ( /usr/glibc-compat/bin/localedef -i pt_BR -f UTF-8 pt_BR.UTF-8 || true ) && \
    echo "export LANG=pt_BR.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    apk del glibc-i18n && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ARG BUILD_DATE

LABEL org.label-schema.version="1"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="Alpine"
LABEL org.label-schema.vendor="Alpine"
LABEL org.label-schema.description="Imagem alpine base"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.url="https://alpinelinux.org/"
LABEL org.label-schema.vcs-url="https://github.com/Jarzamendia/alpine"
FROM alpine:3.20.7

ENV MECAB_VERSION 0.996.11
ENV IPADIC_VERSION 2.7.0-20070801

RUN set -eux; \
    \
    apk add --no-cache --virtual .build-deps tar gettext-dev g++ make \
    && wget -O mecab.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-${MECAB_VERSION}.tar.gz" \
    && wget -O mecab-ipadic.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-ipadic-${IPADIC_VERSION}.tar.gz" \
    && mkdir -p /usr/src/mecab \
    && tar -xzC /usr/src/mecab -f mecab.tar.gz \
    && tar -xzC /usr/src/mecab -f mecab-ipadic.tar.gz \
# build MeCab
    && cd "/usr/src/mecab/mecab-${MECAB_VERSION}" \
    && ./configure --enable-utf8-only \
    && make -j$(nproc) && make install && \
# build the dictionary
    cd "/usr/src/mecab/mecab-ipadic-${IPADIC_VERSION}" \
    && ./configure --with-charset=utf8 \
    && make -j$(nproc) && make install \
# install the runtime dependencies
    && find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec scanelf --needed --nobanner --format '%n#p' '{}' ';' \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
        | xargs -rt apk add --no-cache --virtual .mecab-rundeps \
# clean up
    && apk del --no-network .build-deps \
    && rm -rf /usr/src/mecab \
    && mecab --version

CMD /usr/local/bin/mecab

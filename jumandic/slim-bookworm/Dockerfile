FROM debian:bookworm-20240612-slim

ENV MECAB_VERSION 0.996.11
ENV JUMANDIC_VERSION 7.0-20130310

RUN set -eux; \
    \
    apt-get update && apt-get install -y --no-install-recommends \
        tar wget g++ make ca-certificates \
    && wget -O mecab.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-${MECAB_VERSION}.tar.gz" \
    && wget -O mecab-jumandic.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-jumandic-${JUMANDIC_VERSION}.tar.gz" \
    && mkdir -p /usr/src/mecab \
    && tar -xzC /usr/src/mecab -f mecab.tar.gz \
    && tar -xzC /usr/src/mecab -f mecab-jumandic.tar.gz \
# build MeCab
    && cd "/usr/src/mecab/mecab-${MECAB_VERSION}" \
    && ./configure --enable-utf8-only \
    && make -j$(nproc) && make install \
    && ldconfig \
# build the dictionary
    && cd "/usr/src/mecab/mecab-jumandic-${JUMANDIC_VERSION}" \
    && ./configure --with-charset=utf8 \
    && make -j$(nproc) && make install \
# clean up
    && rm -rf /usr/src/mecab \
    && apt-mark auto '.*' > /dev/null \
    && find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' \
        | awk '/=>/ { print $(NF-1) }' \
        | sort -u \
        | xargs -r dpkg-query --search \
        | cut -d: -f1 \
        | sort -u \
        | xargs -r apt-mark manual \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* \
    && mecab --version

CMD /usr/local/bin/mecab

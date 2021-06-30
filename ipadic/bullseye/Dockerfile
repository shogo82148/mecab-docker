FROM buildpack-deps:bullseye

ENV MECAB_VERSION 0.996.6
ENV IPADIC_VERSION 2.7.0-20070801

RUN set -eux; \
    \
    wget -O mecab.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-${MECAB_VERSION}.tar.gz" && \
    wget -O mecab-ipadic.tar.gz "https://github.com/shogo82148/mecab/releases/download/v${MECAB_VERSION}/mecab-ipadic-${IPADIC_VERSION}.tar.gz" && \
    mkdir -p /usr/src/mecab && \
    tar -xzC /usr/src/mecab -f mecab.tar.gz && \
    tar -xzC /usr/src/mecab -f mecab-ipadic.tar.gz && \
# build MeCab
    cd "/usr/src/mecab/mecab-${MECAB_VERSION}" && \
    ./configure --enable-utf8-only && \
    make -j$(nproc) && make install && \
    ldconfig && \
# build the dictionary
    cd "/usr/src/mecab/mecab-ipadic-${IPADIC_VERSION}" && \
    ./configure --with-charset=utf8 && \
    make -j$(nproc) && make install && \
# clean up
    rm -rf /usr/src/mecab && \
    mecab --version

CMD /usr/local/bin/mecab

# MeCab

This is Docker image collection of [shogo82148/mecab](https://github.com/shogo82148/mecab)
which is Unofficial fork of [taku910/mecab](https://github.com/taku910/mecab) (Yet another Japanese morphological analyzer).

## Quick reference

- **Maintained by:** [shogo82148](https://github.com)
- **Dockerfile**: https://github.com/shogo82148/mecab-docker

## Available Dictionaries

- ipadic
- jumandic

Only UTF-8 encoded dictionaries are supported.

## Available Tags

- ipadic-bookworm
- ipadic-slim-bookworm
- ipadic-bullseye
- ipadic-slim-bullseye
- ipadic-buster
- ipadic-slim-buster
- ipadic-alpine3.20
- ipadic-alpine3.19
- ipadic-alpine3.18
- ipadic-alpine3.17
- ipadic-alpine3.16
- jumandic-bookworm
- jumandic-slim-bookworm
- jumandic-bullseye
- jumandic-slim-bullseye
- jumandic-buster
- jumandic-slim-buster
- jumandic-alpine3.20
- jumandic-alpine3.19
- jumandic-alpine3.18
- jumandic-alpine3.17
- jumandic-alpine3.16

# License

Dockerfiles are available under [the MIT License](https://github.com/shogo82148/mecab-docker/blob/main/LICENSE)

These images contain MeCab, ipadic, and jumandic.
The license information can be found in [CREDITS](https://github.com/shogo82148/mecab-docker/blob/main/CREDITS).

# Usage

The images are available on DockerHub, GitHub Packages Container registry, and Amazon ECR Public Gallery.

- https://hub.docker.com/r/shogo82148/mecab
- https://github.com/shogo82148/mecab-docker/pkgs/container/mecab
- https://gallery.ecr.aws/shogo82148/mecab

## DockerHub

```
$ docker run -it --rm shogo82148/mecab:ipadic-slim-bullseye
すもももももももものうち
すもも  名詞,一般,*,*,*,*,すもも,スモモ,スモモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
の      助詞,連体化,*,*,*,*,の,ノ,ノ
うち    名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
EOS
```

## GitHub Packages Container registry

```
$ docker run -it --rm ghcr.io/shogo82148/mecab:ipadic-slim-bullseye
すもももももももものうち
すもも  名詞,一般,*,*,*,*,すもも,スモモ,スモモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
の      助詞,連体化,*,*,*,*,の,ノ,ノ
うち    名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
EOS
```

## Amazon ECR Public Gallery

```
$ docker run -it --rm public.ecr.aws/shogo82148/mecab:ipadic-slim-bullseye
すもももももももものうち
すもも  名詞,一般,*,*,*,*,すもも,スモモ,スモモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
も      助詞,係助詞,*,*,*,*,も,モ,モ
もも    名詞,一般,*,*,*,*,もも,モモ,モモ
の      助詞,連体化,*,*,*,*,の,ノ,ノ
うち    名詞,非自立,副詞可能,*,*,*,うち,ウチ,ウチ
EOS
```

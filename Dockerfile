# Official Python base image is needed or some applications will segfault.
ARG PYTHON_VERSION
ARG ALPINE_VERSION
FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

# PyInstaller needs zlib-dev, gcc, libc-dev, and musl-dev

RUN apk --no-cache add \
        build-base \
        git \
        zlib-dev

# Install pycrypto so --key can be used with PyInstaller
RUN pip install pycrypto

ARG PYINSTALLER_TAG

# Build bootloader for alpine
RUN git clone --depth 1 --single-branch --branch ${PYINSTALLER_TAG} https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller \
    && cd /tmp/pyinstaller/bootloader \
    && python ./waf configure --no-lsb all \
    && pip install .. \
    && rm -Rf /tmp/pyinstaller

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]

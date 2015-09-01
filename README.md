# bsdunzip, libarchive(1) unzip(1) from FreeBSD

A [BSD-licensed](LICENSE) implementation of unzip(1), utilizing libarchive(1) as
the backend for interaction with the ZIP format. It is imported from the
[FreeBSD tree](https://github.com/freebsd/freebsd), with minor tweaks to make it
work on Linux (only two lines changed).

It is designed to provide an interface compatible with Info-ZIP's
[unzip(1)](http://www.info-zip.org/UnZip.html).

## Requirements
- [libarchive](https://github.com/libarchive/libarchive)

## Installation
**Exherbo users, there is an exheres in ::somasis; app-arch/bsdunzip.**

1. `git clone https://github.com/Somasis/bsdunzip` or [download a release] [1].
2. `make`
3. `make install`

## Usage
After installation, you can read the manpage with `man bsdunzip`. A brief
listing of options and arguments is listed if you run `bsdunzip` with nothing as
arguments.

# Appleboy: homebrew-tap

[![test](https://github.com/appleboy/homebrew-tap/actions/workflows/testing.yaml/badge.svg)](https://github.com/appleboy/homebrew-tap/actions/workflows/testing.yaml)
[![update](https://github.com/appleboy/homebrew-tap/actions/workflows/update.yaml/badge.svg)](https://github.com/appleboy/homebrew-tap/actions/workflows/update.yaml)

Homebrew repository to install tools on macOS.

## Support Tool

* [CodeGPT](https://github.com/appleboy/CodeGPT)
* [drone-ssh](https://github.com/appleboy/drone-ssh)
* [drone-lambda](https://github.com/appleboy/drone-lambda)
* [drone-git-push](https://github.com/appleboy/drone-git-push)
* [drone-scp](https://github.com/appleboy/drone-scp)
* [gorush](https://github.com/appleboy/gorush)

## Prepare

```sh
brew tap appleboy/tap
```

## Install

CodeGTP

```sh
brew install codegpt
codegpt -h
```

## Upgrade

```sh
brew untap -f appleboy/tap
brew tap appleboy/tap
```

Once you updated the tap, you can upgrade via

```sh
brew update && brew upgrade codegpt
```

## Uninstall

```sh
brew uninstall codegpt
```

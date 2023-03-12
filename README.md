# Appleboy: homebrew-tap

Homebrew repository to install tools on macOS.

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
brew untap appleboy/tap
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

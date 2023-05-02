#!/bin/sh

binaries="drone-lambda codegpt drone-git-push drone-scp drone-ssh gorush"
for bin in ${binaries};do
  file="${bin}.rb"
  case "$bin" in
    *)
      git_url="https://github.com/appleboy/${bin}"
      supported_os="linux-amd64 linux-arm64 darwin-amd64 darwin-arm64";;
  esac
  latest=$(curl -skL -o /dev/null -w %{url_effective} "${git_url}/releases/latest")
  version="${latest##*/v}"
  echo "update ${bin} version: ${version}"

  file_url="${git_url}/releases/download/v${version}"
  for os in ${supported_os}; do
    sha256_file="checksums.txt"
    sha256=$(curl -skL "${file_url}/${sha256_file}" | grep ${os}.xz | awk '{print$1}')
    if test -z "$sha256"
    then
      sha256=$(curl -skL "${file_url}/${sha256_file}" | grep ${os} | awk '{print$1}')
    fi
    echo "update ${bin} os: ${os}, sha256: ${sha256}"
    sed -r "s/^(\s+when \"${os}\" then).*\"(.*)$/\1 \"${sha256}\"\2/" -i "${file}"
  done
  sed -r "s/^(\s+version).*/\1 \"${version}\"/" -i "${file}"
done

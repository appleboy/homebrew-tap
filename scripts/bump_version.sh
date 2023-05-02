#!/bin/sh

binaries="drone-lambda"
for bin in ${binaries};do
	file="${bin}.rb"
	case "$bin" in
		drone-lambda)
			git_url="https://github.com/appleboy/drone-lambda"
			supported_os="linux-amd64 linux-arm64 darwin-amd64 darwin-arm64";;
		*)
			>&2 echo "Error: unrecognized binary ($bin)"
			exit 1;;
	esac
	latest=$(curl -skL -o /dev/null -w %{url_effective} "${git_url}/releases/latest")
	version="${latest##*/v}"
  echo "version: ${version}"

	file_url="https://github.com/appleboy/${bin}/releases/download/v${version}"
	for os in ${supported_os}; do
		sha256_file="checksums.txt"
		sha256=$(curl -skL "${file_url}/${sha256_file}" | grep ${os}.xz | awk '{print$1}')
    echo "sha256: ${sha256}"
		sed -r "s/^(\s+when \"${os}\" then).*\"(.*)$/\1 \"${sha256}\"\2/" -i "${file}"
	done
	sed -r "s/^(\s+version).*/\1 \"${version}\"/" -i drone-lambda.rb
done

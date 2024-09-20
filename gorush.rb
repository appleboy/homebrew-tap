class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.8"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "gorush: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "gorush-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/gorush/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "9cfb5a404093d62c702b248036bfdd2f7fe3cb816b653c51147b61b8b80521ad"
    when "linux-arm64" then "0bce5da3dd2061858e0f751a159a17269b68255a69b76887a0e4c78fce369ad6"
    when "darwin-amd64" then "18f95229a49534b113ef99d5d8d65bb318a3cca1603c6545f3326fffadc240b0"
    when "darwin-arm64" then "40630db2495a2289f8643a7428ef01f8e76f8a4603c3f420aca956d9b4c9a273"
    else
      raise "gorush: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "git"
  depends_on "zsh" => :optional

  def install
    filename = Gorush.class_variable_get("@@filename")
    bin.install filename => "gorush"
  end

  test do
    system "#{bin}/gorush", "--version"
  end
end

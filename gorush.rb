class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.17.1"

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
    when "linux-amd64" then "26f048d5b5558c12f2e0bc6c81d072989b58fed973e34ecdec095741690589fc"
    when "linux-arm64" then "9ea1247dcdc002a0674026e000d5365a0ac30a2a5dceb9ca242f8a6bdc2da15d"
    when "darwin-amd64" then "f3185161c3f2ccdff3e406ab5f6a069285009c7595b9879c9b154e4d0bff9f28"
    when "darwin-arm64" then "bfe7e8145deb9a9569a94b45ecfe1f431e128f5a4e4e15b451d3bd78b1ebec4c"
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

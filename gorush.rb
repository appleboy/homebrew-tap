class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.7"

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
    when "linux-amd64" then "21b6acaed976039d68b1b0c340c20ad77957c96b69f2a206c4a55d07aa38cf1f"
    when "linux-arm64" then "58051ce9b6e4f218472507009addf176add6636d16584e6ec392168e14540ebc"
    when "darwin-amd64" then "764da1a114ea676fa2100e8255c49c80fc929da33edd1c133f3bb7ce6e951470"
    when "darwin-arm64" then "81c23cb4d43c2bd93aee7d44914f8b888fc7d28fdd9db1ea7bfb64cb3ced8bf8"
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

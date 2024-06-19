class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.4"

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
    when "linux-amd64" then "833e6afd0842f73cd667f075711428c7e5228060eda0fc186bae296d0b213122"
    when "linux-arm64" then "19ea4d1699ee1b6f9b9941327d5fd32ab438ae885f824ea486e81b99415765d7"
    when "darwin-amd64" then "56b4f6644acd4a860f01070505e25336ae3e72815d514704a43aff820ca94a4f"
    when "darwin-arm64" then "aa4486d51403fa8688606f447ba8a014d241a3bb361486c6432a6b8503fbcc7a"
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

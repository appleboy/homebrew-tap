class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.5"

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
    when "linux-amd64" then "08576714a4b67a51b1479d220210d89199133e40a667592a3710c4f9476258ae"
    when "linux-arm64" then "63350ab07cccc0cb6c49752d0a58dcc744c8ffdf7d7f06b9e3f53657b7b4428c"
    when "darwin-amd64" then "d837756bc5b56376b14c57fe939129a7f9b956ead16be2497c47c523b8e8ba7d"
    when "darwin-arm64" then "29a39c4675219b54b8755c9597b0db6316317368e6e28f136fae22ecb48ff936"
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

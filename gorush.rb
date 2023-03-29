class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.16.3"

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
    when "linux-amd64" then "db90f81fabc3c8afbba8d0c05f2adcae52ec537c5b8207b7f499b0efee35a5bb"
    when "linux-arm64" then "4aad5ead470d46dcf62be3a0df5a34dd175101c75697a5242feec70c754d9b28"
    when "darwin-amd64" then "b4d9f5481c4cf56c7237d6cb7007b33f541ddc77cdebb1cfd373c6ada396c047"
    when "darwin-arm64" then "8aa558a0612bfafbd867135c1e6ac0054a268ad959e3f59aae96dd122a8a3803"
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

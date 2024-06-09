class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.1"

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
    when "linux-amd64" then "3c6098b3f8ce585874e3c8e00eeaceddc2956feac9d2641ad1ac418100bd9835"
    when "linux-arm64" then "ca009dbb8ce4a7a2aaccbeed6a7cfca020bfe729648199e2556c52b6632ed4a6"
    when "darwin-amd64" then "e68b55a445f8d136c4931356df6087df1e2377a584528ba4da34980abb85e434"
    when "darwin-arm64" then "fa9e2bcffdced811a2886df8cdeb030bcfaa09813f867c08c0e9e7dedb522c35"
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

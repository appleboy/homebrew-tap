class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.17.0"

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
    when "linux-amd64" then "5be6da5b6c742400c0847ddb2ca15c87ec785447fb2ab76f848c03e50166b39b"
    when "linux-arm64" then "9662eb3d1c39ddc365edcf0c826ce92a40768125cc9adea96bd07f2bc064c622"
    when "darwin-amd64" then "f247648ed904214d333d158ba5b64337955b3dc8d3bc85a2c2112a4c79731a3b"
    when "darwin-arm64" then "e7f8aa495e799ca51ee093cc561a36c284b90c457b0119bd4a387367fd3a2832"
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

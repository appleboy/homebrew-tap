class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.8.7"

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
    when "linux-amd64" then "dad1fe3fc583612fecdcea0c59e06fb065b9c6e04e83370fee1494bdc87df5fb"
    when "linux-arm64" then "002b55acef82412e8ec46a31b171532029a8793cc2839dc5a28b0d504020ce03"
    when "darwin-amd64" then "ad8da8c90ffa0aad7781618c8ac45a23db2cd57def9affef511ff1f01580d6f3"
    when "darwin-arm64" then "4b1393ecfc57c31b547cf259a2b5769d0bd0eee620846a3a9bd91409c6104881"
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

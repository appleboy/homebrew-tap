class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.3"

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
    when "linux-amd64" then "2411448dc084e53a119aaed1b31893735598ff6e38adbdb471f21a1f854aebf8"
    when "linux-arm64" then "040eb897801df003402e475964fc4c16c34302ee02eb771ec3b9510f5dbca1a2"
    when "darwin-amd64" then "b79add240e6904724449172a7dbd284c989aa6c086995db2a5c0751452c09704"
    when "darwin-arm64" then "90d74e0a90fe69393d2ce847eef241878a0ec2f9c90adef525ba82cbcb6630f2"
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

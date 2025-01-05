class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.9"

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
    when "linux-amd64" then "5b18faf574521a124705ea6d0e512cff5a2351f8db3c5896e9a14abdac618fc9"
    when "linux-arm64" then "bdf0f06faec50785a3492f466cb7e2dfa1200bbc2aa6b79cd4d9e43995956a64"
    when "darwin-amd64" then "1ce66da5aa849a469c147c970ca7794761b282e064f600aaf30085eacfeb9145"
    when "darwin-arm64" then "b01cd7b2d43a17bc7ddb3807eb8b8deee715aedbc7ad99e56572122f006e4283"
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

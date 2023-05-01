class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "0.1.4"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-git-push: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-git-push-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-git-push/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "6258af5e986b81665a53001717a58e8505131d08668f151740a3e4a26c6376a1"
    when "linux-arm64" then "6025bc2eacc5707192f2aa0df0b010458c69a87c1cf3968df6367cc05b2f09b4"
    when "darwin-amd64" then "51aac41f627c433a354a71df9b0817d7e872a81b0377524b14e29a7959bcc4f9"
    when "darwin-arm64" then "7d65f2d11b88cd6ae46dfddee2bb261faf3b596a1cf12f3d311f5315c14ea0ed"
    else
      raise "drone-git-push: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "git"
  depends_on "zsh" => :optional

  def install
    filename = DroneGitPush.class_variable_get("@@filename")
    bin.install filename => "drone-git-push"
  end

  test do
    system "#{bin}/drone-git-push", "version"
  end
end

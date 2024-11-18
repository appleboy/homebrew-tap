class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "1.1.1"

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
    when "linux-amd64" then "2d71969019986b72c74894a2f712963bc7ae988a28acf20dead1c682b5465e51"
    when "linux-arm64" then "7371ca384e14a636f5023ae10fd7da1b2cfd47fb955b6d6e83b60586640f864e"
    when "darwin-amd64" then "c3851e040b255be16d2ad7ce9ff12bb1377bfb6d95dbfe24639e96f3b55d40ab"
    when "darwin-arm64" then "39ab8ebc1aee88635dca3f53980765ede55c9238a20eb8e75f3df408b17fd790"
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

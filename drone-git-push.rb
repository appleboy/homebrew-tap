class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "1.1.0"

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
    when "linux-amd64" then "ca69aa582995c6d4609729941d6debcf5448ab4db7154ce56f7161691764d6d5"
    when "linux-arm64" then "f1e92a82dcaff0d269c556b197950b694ed1c651853039d501b868553143cfbc"
    when "darwin-amd64" then "77e4955b5604dd290c91c382c5d203ec8317d59437957250ab931e0cc2281bf5"
    when "darwin-arm64" then "f03c9c0314ee5f9a166d20e57bc49df0941419bcda859f0e7af85e8168cd51c6"
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

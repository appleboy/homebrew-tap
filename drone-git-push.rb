class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "1.0.4"

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
    when "linux-amd64" then "1d0274e679184bff298f1528c57e7d4bb58b59321004dd09d1fcc736f5bd237d"
    when "linux-arm64" then "6d2f5b5114866819169cdeda8245ee44dbe9163626373a1af4471f99f9e09f90"
    when "darwin-amd64" then "dbb076421c0fcc9283006f31423f4093756cada51d0aa5e0c805b01a35b9cf01"
    when "darwin-arm64" then "f5568d02ef6cdd5ac29127082ab849f64cb502030c9c84bcceaf8f03af06ae62"
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

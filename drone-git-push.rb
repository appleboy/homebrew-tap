class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "1.0.5"

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
    when "linux-amd64" then "a4a9a4864afd2fd7bc9d56db675d7164a2a2714b01d866d74f8a5d6c4367f99f"
    when "linux-arm64" then "3c269955afce253498b8671194b4cfd1e18ba8a3d0034fb5c2bb67ee473787bf"
    when "darwin-amd64" then "890e9173f2cb29d4b3170af0ff97661e12c86bbff605da746f35498f10933048"
    when "darwin-arm64" then "871fae48d012723371010435753121dad8c24ece3e5eb4ff2d8a73cb48e18a54"
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

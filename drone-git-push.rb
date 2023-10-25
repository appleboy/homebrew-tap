class DroneGitPush < Formula
  desc "Drone plugin for deploying code using git push"
  homepage "https://github.com/appleboy/drone-git-push"
  version "1.0.6"

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
    when "linux-amd64" then "3bbfb8da90ea5e23a3c1ff2ae61f64210ac106619e0703a5b517632147837706"
    when "linux-arm64" then "910a8f8ed7dc83b2bf16d49aa24ef417be9cf51b5c4cd72a485594d0ff68de5f"
    when "darwin-amd64" then "e807166755e2a5b6ff57eb89f877220a8b3422b4c2574bfb1866d617b28940c1"
    when "darwin-arm64" then "2ac90ba877b98a111cf0078b6e53d3d734c6fe5ea236cd070396c866ac85ba99"
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

class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.0.9"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "CodeGPT: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "CodeGPT-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/CodeGPT/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "9123176d14c526ea221b33c954ac118f207fcaf76cc8291617c2a5730c9ed2d3"
    when "linux-arm64" then "5cc245cf3de230ef25191e9f9dd015a27b05f83f54380986d1fb7f9609a67f3e" # binary
    when "darwin-amd64" then "0c8b3ef6132b7b89d549510f83a46417ff4129e8411eab9e4c4cb198fc0319f4"
    when "darwin-arm64" then "336d21c515c1d17d228f4d68f7f98dad4b3662d36b1cefe8f2445b4a5925d279"
    else
      raise "CodeGPT: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "git"
  depends_on "zsh" => :optional

  def install
    filename = Codegpt.class_variable_get("@@filename")
    bin.install filename => "codegpt"
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end

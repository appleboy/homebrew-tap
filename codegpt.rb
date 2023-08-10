class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.4.1"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "CodeGPT: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "CodeGPT-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/CodeGPT/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "b9d39bb2e9144bfae57b7ca5765f6e9bb46cf794671963f8485b16163fa4dbb1"
    when "linux-arm64" then "b4b2341d9387b88e33b0d18ecf120a1708313bf6ab95715d34a29f9c8a4ce623"
    when "darwin-amd64" then "8c6f34b46be0187ce6d31ca824f17471fba884cf2b3147494ba9ca9903a4c2eb"
    when "darwin-arm64" then "6d447b06ce7d74b1c2f26775d5b8dce15f144f4120eeeb058d7289b20b404b3c"
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

class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.2.0"

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
    when "linux-amd64" then "1b1b663725e98413f4d9e0015883a0ba1facd46ed33bd581dd6a1518c6a66ae0"
    when "linux-arm64" then "6d4c4216a2c9b3f04e0654f0a579cec5a926a9e62edf74ab5a3682c9c6cd0c01"
    when "darwin-amd64" then "edd93b519a4d2f12163a6af5a8e5d53e827cdfd11938cf1b47f5e1b4bb2ae9fc"
    when "darwin-arm64" then "b2c71262e75c677d22ce33b111df449a57cf523794110ed6be4c4a4ce7f80ef6"
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

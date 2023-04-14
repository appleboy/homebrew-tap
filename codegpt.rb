class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.1.8"

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
    when "linux-amd64" then "24b869d66a8a31c5f127a9dcbdd1909eee4a44b8c8deb5d4ba1fea25b4bcb1b7"
    when "linux-arm64" then "0bd9577cea5731af365c37fe9d9a7e13d7c75f8aa002fd2cf068e15412b3b8c6"
    when "darwin-amd64" then "ed1b1e2d116876604b782d16fa1f1b24ff36a3895e267e7770c6bfe9c1874826"
    when "darwin-arm64" then "aec60b2c924c80fe6a12f1aa0914a427d7524fe9acbd00194846f5cdca1e0450"
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

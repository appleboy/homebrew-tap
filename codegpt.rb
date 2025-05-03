class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "1.0.0"

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
    when "linux-amd64" then "613e3bce20ea48fda9b4f67570d28f0a35c529d11e1f2930ddf3c23d4347f3fc"
    when "linux-arm64" then "73e90c74a56c62bbf1c9e4483d6ab36d823fdc7aa93f0d20108a459f726f62fc"
    when "darwin-amd64" then "9c7c6861b4a97b76760ed92675ebd6d261dc5530b7d07254b6ddb3d53eec499c"
    when "darwin-arm64" then "3ab04ad37f2feb6fd96a5909b73be38cad391a63b65b4dc88e4a3c70aa50338a"
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

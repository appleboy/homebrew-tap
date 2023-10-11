class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.4.4"

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
    when "linux-amd64" then "f14b045e4b57cb4dfcb2adbbc083e936785f02b37281463180fcfe1c5c98574f"
    when "linux-arm64" then "8769c1fefc4f1e1d6571cc5778a2f1eddb04afb92d9e32eb60fd06324fd43e4a"
    when "darwin-amd64" then "1c4976a5b16f9d0733f1ac48fde3b95b08bd0fde639c541806d056f498cbd5cb"
    when "darwin-arm64" then "adb69a075fb9448bbed94228cb7b0a45be8ac9214062ab2ed1ebd0f447ce86e0"
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

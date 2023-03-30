class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.1.5"

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
    when "linux-amd64" then "e4bc41117e8bca879ba67027d8e51a627ac043dc59aac5564de72f47599c683f"
    when "linux-arm64" then "d2a8d357d43e4fcd0b43fe7cfdefb831e289c126c5671ab677a9eb131a001acd"
    when "darwin-amd64" then "28bd32894a199605c091b697f30f2874aa8135beedff12bcfe8c2f290864c6d0"
    when "darwin-arm64" then "fb031a59494f68ca35d2070697288d60d64fb9a3f75fdd1122fb21cd5440aceb"
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

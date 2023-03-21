class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.1.1"

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
    when "linux-amd64" then "ab823fd5c0fdd0e22f2d962c929a938f680d162d82f7733f8984e7407d537347"
    when "linux-arm64" then "919a5378629249bdee801e141f0a74e4a76447d4c6e82c8b2bc6e265e287d05a" # binary
    when "darwin-amd64" then "d5b24c69e34af5c2a99883c8fa00bed580bb4bbb3ac04a188f10a569ea182ac4"
    when "darwin-arm64" then "5220dd39931a212c8d0e59ee5a65636a172cc7ebdd2aa575beb940c83c83d388"
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

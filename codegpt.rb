class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.1.0"

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
    when "linux-amd64" then "398d8c9b0491a2ba88e6e4306a037905cb2d2897857dde852c40efc6f290dadc"
    when "linux-arm64" then "fbec88fe00c178a9aa3d7661e89e5571ca83f915537b3e1fd59de1c2a1040c1c" # binary
    when "darwin-amd64" then "a07a186be6f9498a2206498dbfa382955f834f5b74a8547ff8476e924de005c3"
    when "darwin-arm64" then "56d9e09cfd32f5ed36e6e260c31acfc3649e593b08bc4f2f56e4d9f2c9d83e33"
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

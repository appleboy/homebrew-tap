class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.0.8"

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
    when "linux-amd64" then "aa265eb45b0c0ebb3c069a2691b01845a43245e53a797c45940b385fb470044c"
    when "linux-arm64" then "9877fb1f3a503475da2391992c0d48ac2b5bdce9aa98426d0ed328ad8ca3661a" # binary
    when "darwin-amd64" then "73c449016e827c986621f1f52c04bd3dd110f82a6c26414a6f801fa5395944e4"
    when "darwin-arm64" then "a0afb0232476574e37a6f07c43e9ff16af2afcf4a27ade25d5cf2c45213efba9"
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

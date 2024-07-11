class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.14.1"

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
    when "linux-amd64" then "74ce46d0ce023bbeb9875e4c8ff4a4e18cccfd87886e5a49c7b5ab714e2d6e3b"
    when "linux-arm64" then "0265ec400a129d324411c2074a470dcfb46440c804b96b0e7c6af5ff393ac637"
    when "darwin-amd64" then "9d24993ccb7c23bf7fbdc90f7365e5dcdffaa35634f8fd464d7085f0c451846f"
    when "darwin-arm64" then "ef20f221f409292fcedc36aa068a40ab1737c1ea76fb17040ec3a4ed3fad6cc5"
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

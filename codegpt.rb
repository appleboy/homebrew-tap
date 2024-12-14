class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.14.6"

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
    when "linux-amd64" then "069c49b5335e61dbc207e8badf4929496b8b51c6ffaadf9d8464bb852c338073"
    when "linux-arm64" then "6adf6b9d7d0ff28b67c8c4263077ef17123881e1f3d26265cc2cf5e65fa6b0da"
    when "darwin-amd64" then "7ee9b079565f8ce431586bb112b7331bb77fa659d4bcd96fd7106b60712736c4"
    when "darwin-arm64" then "f77a63c70770f7be7bffa2eed08ec1ab5fc4483a076d9f86ff522df99ae3a55b"
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

class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.14"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-scp: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-scp-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-scp/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "19d82ce47efc3cc0b6219f0ec54152759858e00084878d2d79aa0b4eda3cc90e"
    when "linux-arm64" then "f0e6b3206b09c7d14d56168b81159e896ba47862f561a913f692a0a525d090d5"
    when "darwin-amd64" then "bcbce3f48085554dc31031d6e2f90674772c8db9ed2e045894d6b957624ba8de"
    when "darwin-arm64" then "19085b069e4ec8d43ad835948f2c4902ce27a599d6252ea150dfdab695850e1a"
    else
      raise "drone-scp: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = DroneScp.class_variable_get("@@filename")
    bin.install filename => "drone-scp"
  end

  test do
    system "#{bin}/drone-scp", "version"
  end
end

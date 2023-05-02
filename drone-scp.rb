class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.10"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-scp: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-scp-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-scp/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "066e118dbd6f2a2cdcbb9f95124a4f04a084c26d03fbb4fe9a140f85095111a4"
    when "linux-arm64" then "19cd7e63d064c45d942047b1b267492c9cea016c1e9062ad53ebaf48bfcccdc2"
    when "darwin-amd64" then "4236a317237ac8942582146d013c2adb89c5bf082d9b8af62b41ff95b5564b5f"
    when "darwin-arm64" then "205ef0869c6bfc8682b90fa14d12815890f2e14624757a9ac2c34e412a8e2ecb"
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

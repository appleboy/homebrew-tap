class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.12"

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
    when "linux-amd64" then "20e390dba61635be8bc6c9844100f76c18fa7620c86a7dba97cb6773ae7ecbcc"
    when "linux-arm64" then "dac796c60bd3bec52a17cb9d1a28dfc6741574e75724265daaaf85e715208171"
    when "darwin-amd64" then "3046e691c6764ac6493db71c39fff4ba4d474fc76f5c84b3e1450a4d3ea11816"
    when "darwin-arm64" then "a5c6bddaf86fcb093fea12116b2bbc1cd5af3402aa397ae727fc01f285c5bd75"
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

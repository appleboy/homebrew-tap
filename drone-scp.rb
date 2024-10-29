class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.7.0"

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
    when "linux-amd64" then "3d17de453ad6948bbf79aed79445eb2f0c437004a180f272546ad850fc51218c"
    when "linux-arm64" then "7022d5facbe8dedf5158b4a6ebc09ff94be07596267f7a6f68ae16b3a9595873"
    when "darwin-amd64" then "8a4e0d94df5c8da096104ce0d94a00ae9470fbd5af2ba3e51b8085948d0fb320"
    when "darwin-arm64" then "d9b9b2da9bfc92459601b562dffb129fbf5371dbd1dcb6a3bfd801b1178114fb"
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

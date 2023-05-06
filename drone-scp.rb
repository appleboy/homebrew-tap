class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.11"

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
    when "linux-amd64" then "91132ae908f34a86c63225f748dea640f9ea374d168d7eae4d887c1f8270cfbf"
    when "linux-arm64" then "39a3e67966b6f536aa28d71722870e559925d99cb1c7441cbc2f4a1d4959aaa3"
    when "darwin-amd64" then "d62410b40b7120a7d0e597245e7a735d87e12f513c0ac5f54a10626e97018596"
    when "darwin-arm64" then "0f76d7eb07b1d8ecd8d113aac58f855b3d7b4c7b7fb095c8908f024eb712c5cb"
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

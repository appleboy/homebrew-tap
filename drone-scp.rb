class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.13"

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
    when "linux-amd64" then "4805c4f120fea4d9c92a9995acf8bdbe139e3163e92e04c5113ad8c4216cf1f8"
    when "linux-arm64" then "74854c50cf0e142af2fb7363ca90e45cc18926626307c424dfa1ffc5eb6ab4f9"
    when "darwin-amd64" then "023bc798357f05a3339b9420a524061b0ceaf36b74d6b44dae5d4ac419428077"
    when "darwin-arm64" then "99547cac8a57877008f42871b303e072280e5ae037c3d94aed75679380aa9475"
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

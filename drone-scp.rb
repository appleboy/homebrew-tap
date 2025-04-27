class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.8.0"

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
    when "linux-amd64" then "4f35eb816360dcf5c60e44c12dd6333cdc5092b65f64a4666becae7745f3ba67"
    when "linux-arm64" then "0f25210e7b3b5f264e9b089e02eddd0a13411b10782d7f3d4d61c6ea2b0a6757"
    when "darwin-amd64" then "f19766852cc6f2cb5fb42ccc773b5e1f43d1da096d5452dd763b6a508b24ec0f"
    when "darwin-arm64" then "20e9aca9e5d49bf43bf0e32a90632fa28c3169cc53a60783357a995086627ab3"
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

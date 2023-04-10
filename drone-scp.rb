class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.7"

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
    when "linux-amd64" then "a83df070ecfd3882b1f611ce9f88c9ac42fc45018b4853228a8faef13276cf3e"
    when "linux-arm64" then "23b9c8b6d0b5ad4408ed533ae866356238214299b2122b0b35675b4cb4b0ea5b"
    when "darwin-amd64" then "36988701352bdda9f24a10a2173d254a098343aa34008d84c3a2e746fb106dfe"
    when "darwin-arm64" then "b57cb8cd4f7c19a157cf71c3773b45e82499c0a4a941c81e71760b7018ced336"
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

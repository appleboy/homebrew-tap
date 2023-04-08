class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.6.12"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-ssh: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-ssh-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-ssh/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "7d96205d69db9d29109f5472d9bb376e1c58199349a8ee893a9a0ee6d5f17983"
    when "linux-arm64" then "daa18ad19b413555da3bf0f23a102c8559b3678185eeb467f9c6e045d99a6443"
    when "darwin-amd64" then "2bfbf2c1e7e9818bf414709d2856ea2b29f6f368f0e4873848494ec5ca4ba6b6"
    when "darwin-arm64" then "686986ea1a7d2c7d6ec9d79e42fe1a7c811f1d620850e369dd79a485beedc1cf"
    else
      raise "drone-ssh: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = DroneSsh.class_variable_get("@@filename")
    bin.install filename => "drone-ssh"
  end

  test do
    system "#{bin}/drone-ssh", "version"
  end
end

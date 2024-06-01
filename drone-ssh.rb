class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.6"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-ssh: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-ssh-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-ssh/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "5fc11ddc2395eb588e5c3136b94e55b0ca17979b3528fa8b6dc4ea520f53845b"
    when "linux-arm64" then "1f73cd12552fc301d563785e012aa0b4814061c193c5f318a05c041954bd6f10"
    when "darwin-amd64" then "bb5272e1bde41fec972b435d5ddc2178712d25ae034a7fcd3f1b32fb1ba0627b"
    when "darwin-arm64" then "ff513033fa89b963025f9ebf506bc79659e02b3c2135985e023279a20d016a09"
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

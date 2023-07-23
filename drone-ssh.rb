class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.0"

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
    when "linux-amd64" then "188099f1a3db76cea67a34a2ab00f9e589e53ad386aa75e90a7948ea3778bbc4"
    when "linux-arm64" then "ffb8a6aabc333d9f27f0822149f600de828c6522cdf5f838221aed38c57da00c"
    when "darwin-amd64" then "395574bed0c32f8653984139540f6e728c30044ffbfa404bf671f85cf98368a8"
    when "darwin-arm64" then "bef3fd5eb55bd8f70153a2de89c38332eb787e64bc9f5207a5d9a60af715bed6"
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

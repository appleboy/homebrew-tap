class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.7"

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
    when "linux-amd64" then "e15ecbc4c1908f59a91629db3fc1cde916b7e95493d2e7331bcbf39cfdaa3423"
    when "linux-arm64" then "979fccdf61e29e5552ee582d50b7ae639ee86ea6f79c402458198b7d8683099f"
    when "darwin-amd64" then "6ee532b89c624f1a0557f6fbd81ffa2aec89a69564a59599e7731ef1c9ff73d7"
    when "darwin-arm64" then "34a02cb27828eb8b13678fadeb4776a80c649eddb7136e77a7fdce1219f123be"
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

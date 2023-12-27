class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.1"

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
    when "linux-amd64" then "07db47d810cf4c31ea61329d1ca39887bc799da0bc8f6592eab81c68fdbbb39a"
    when "linux-arm64" then "88decf47d4a2d93cbc1e7e04f4a4b5ee3afc03948fc49cf2e15242bf56545844"
    when "darwin-amd64" then "dc15fca8471fda98b246267d756842c8e07a31793dd4fac6a0b8d8132d4732b4"
    when "darwin-arm64" then "94b3eec3138951736d88d9d27149b070216ef44bbaa6c457e93c5528df44adb2"
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

class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.5"

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
    when "linux-amd64" then "c2a8c9c4f4c4f89e0e236570a6730f306c2d1c8ee36e4c8426fb3176ae13dbed"
    when "linux-arm64" then "ea90e99e2ad9029c09f65ad3b42d3dd5e8a62cc2a0f2af878f8703e2935ab116"
    when "darwin-amd64" then "d16e490390aa6104c695256acca0f8b01e347f327b105fade40dd12c1e9370de"
    when "darwin-arm64" then "f82514b73050b045c4ccbd5e8a631e9d9a48ac92a9f773f83bdc5b113dbedfaa"
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

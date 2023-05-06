class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.6.14"

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
    when "linux-amd64" then "5231cddb184380c3fed1e088489a11d0ff3a78df41b2f626586dd8cd2aa4813a"
    when "linux-arm64" then "1752d4db06d7444b2fe8ca008e7e690b9c1cc4e69fa37c35adf605ced651f902"
    when "darwin-amd64" then "e60aebf933f54b4d83460211170b0f7a7442985af9ec79a46a25e499bd749573"
    when "darwin-arm64" then "5745df5265e576afd09cecbd80c6223e05fca2652729a2201b8286737068458e"
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

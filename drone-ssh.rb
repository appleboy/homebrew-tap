class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.3"

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
    when "linux-amd64" then "b7d4a447b2c7c46c115cec14ce20380fc5cbf67950ba2d72a15473db0f1ebe9b"
    when "linux-arm64" then "afcfe8377b63c27ba9adb92fe429e5fa1cca4972955c46b5ca931981388c118c"
    when "darwin-amd64" then "450149117227f2a39cb61b8ce3d10cbcb885ca6ac2804fa399e44fbc03556baa"
    when "darwin-arm64" then "67aafe18a8b3144116a1bdaecb4312aaa6faf1a0ad989f0a08fa9b5d3c40f16b"
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

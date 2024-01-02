class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.2"

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
    when "linux-amd64" then "eadefed1e4c9c614c15ad88b6ad3fdfe14ef3b24a1e2313cd26a8b690fc11b5f"
    when "linux-arm64" then "cf868e6e8b840579d1a2c0f1e20f17fc0881f80a12cc604f995e31eb75798a71"
    when "darwin-amd64" then "377374922122ad3b96074ebe79937baec8d0ab97b94f04aa6b4b13686e7b7847"
    when "darwin-arm64" then "ef935db140c7d6a9433948e189554ad97e2c12f73dbcc74ce7d63a652be98363"
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

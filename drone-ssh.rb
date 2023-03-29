class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.6.11"

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
    when "linux-amd64" then "151ae9f10389a19c324b1af8a4b74a84f383cbc2fe9cbeaaf8b1b5718d883df0"
    when "linux-arm64" then "8121abfb28c95ef125b8a9425031c2e00947ba8a44ec068ecced030fcde9de3b"
    when "darwin-amd64" then "957424d8281cdf329ed66ecf96f0cac2041964e2a89245a59d0dfe2122695cee"
    when "darwin-arm64" then "ff9538ac7656e8ec5655d43eaa159c20381ee66f5fd3b2240f1c90604dff020e"
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

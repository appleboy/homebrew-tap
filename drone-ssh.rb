class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.8.1"

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
    when "linux-amd64" then "13b773063cbc4ed6f31ab2306be8a866bacb6de3a72799c6314dd95ea7328962"
    when "linux-arm64" then "f7c22b4362554cfd8e5556a46560c88400db40c4c5d249084dd4ea499fd61123"
    when "darwin-amd64" then "02a31ab488e0e6189f4678e00ac1b1b433aa9b59f1fec86779c58ce2558ccbc5"
    when "darwin-arm64" then "213dc199df647ff10cd8af8babb7f87fae0d74e5462837305dfc4220fb7a41e2"
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

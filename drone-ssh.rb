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
    when "linux-amd64" then "2d111bcbf1cd4b7f4bc5888b7aef3b7ed16281abedf2614278946defaa7fd1d8"
    when "linux-arm64" then "dff9100fb7301901b58225bd1011712a018663df32967b4ed641fd093d15eafe"
    when "darwin-amd64" then "06f38500c3a31932bf885e5462c693f52a91ba9aecf424242b3ca22a4e9affcc"
    when "darwin-arm64" then "e5fe14976e3e42bc3291b69d8534a7e87164e09733f32684a47a6fb05eac5822"
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

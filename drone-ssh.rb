class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.6.13"

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
    when "linux-amd64" then "a82d8d91161423720d1389ad3db916fe4e2645163e164e1eb04a7cb36410c325"
    when "linux-arm64" then "d24382af0d3d7818f709d0e0d53d287f261b6b6584e8537e463f38f7041c65e7"
    when "darwin-amd64" then "f99e434a501dd50c2394d8794ee33c5678666d15759f2a46a9e0dc1e8d2a5af0"
    when "darwin-arm64" then "d24382af0d3d7818f709d0e0d53d287f261b6b6584e8537e463f38f7041c65e7"
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

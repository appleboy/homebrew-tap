class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.16.11"

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
    when "linux-amd64" then "23642bd2038c432ee79dfa64832870e9b81a8e149f4ee462910492c8d850ac76"
    when "linux-arm64" then "dd74152fb9377aeecf468b5b2be01415773dac0dae37363e94aa4baaa782099c"
    when "darwin-amd64" then "b7b6ae58ed844332f0f4d351b05218a1efd8f1460a3ee4dcfc50a2c40926490c"
    when "darwin-arm64" then "b8c0e2d53416bfb9626d2b95c077349d38f98c8fbe5174dfc27b299b08b96aa0"
    else
      raise "drone-ssh: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = drone-ssh.class_variable_get("@@filename")
    bin.install filename => "drone-ssh"
  end

  test do
    system "#{bin}/drone-ssh", "version"
  end
end

class DroneSsh < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-ssh"
  version "1.7.4"

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
    when "linux-amd64" then "6dc7c043ddc5c20fb61915776483166067bf4ebc1b8a83f77ab6d435ad77f636"
    when "linux-arm64" then "9aee506d28463ffdb9c0a91b9858ef38ea97cae8acc93cb759d42b7671551b3b"
    when "darwin-amd64" then "b9610d45ed45522212c6a20b7f7fc6a3a28b483923592a337e0d168afd888c2a"
    when "darwin-arm64" then "4fd5e01cd0088c4cbbc7f732b562e6c03a78b03fcff28ef63dfd341b89516f02"
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

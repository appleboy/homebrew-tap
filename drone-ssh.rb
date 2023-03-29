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
    when "linux-amd64" then "ebdde7a2efec8f6e5a3a86f5bc0933f25906a754f321ab55c7b6f576f9944492"
    when "linux-arm64" then "5f157f1a60df9bcc45a16fc50324b06040e9e75925071b354eec379b51cabc7c"
    when "darwin-amd64" then "27afbc2c0cde19d832bc3d4b7be9fbe08ad8fec132c4213056e16fb6ad4b3faf"
    when "darwin-arm64" then "1d2ee638683552f877bd303a4682c72976c29ef1fb4d476180a6c3f0bd7bac75"
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

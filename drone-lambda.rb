class DroneLambda < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-lambda"
  version "1.3.7"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-lambda: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-lambda-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-lambda/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "5334bbce00e4dba4d3be53b081bb2cad796aafb58b450816516bfead3e22ff6f"
    when "linux-arm64" then "55ae895650b5212d23db47a0a1d8047f0216f0a016f76e72d17436a1a0964202"
    when "darwin-amd64" then "15bfa9c6baa586b980222435306d0cbb9104987f96cb609f5dca0652848cb43d"
    when "darwin-arm64" then "d68dbc66d2f80e4d61276d4f18484fcf35882c468fb4ef7cae4ce47e6179fdcf"
    else
      raise "drone-lambda: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = DroneLambda.class_variable_get("@@filename")
    bin.install filename => "drone-lambda"
  end

  test do
    system "#{bin}/drone-lambda", "version"
  end
end

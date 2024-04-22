class DroneLambda < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-lambda"
  version "1.3.8"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-lambda: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-lambda-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-lambda/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "fd230fdbcb7a16a5ff8ad7bcca7a2d94135756b3c9ad124df2251e586ead8635"
    when "linux-arm64" then "d15bfceae28b0a8ae5ff6de644a0b6a97b4accd6b776cf5f55c7b530da13c5cd"
    when "darwin-amd64" then "7d3d648967126f38becd8dc7c3ef037954c27423804de19434cbec97b802f8e3"
    when "darwin-arm64" then "19baafbf242a96e6085d0e23c9b70fbcdb1e31321ea9770b13a44aa261a3dc7b"
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

class DroneLambda < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-lambda"
  version "1.3.5"

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
    when "linux-amd64" then "3a1fdc584b380e97f13b8a15d23448f011085e936886b3dc1ff607ca705f4715"
    when "linux-arm64" then "49ff95f2a26232e22c757024191c495903f0efaa987ee22f9e652d35d5abfdc2"
    when "darwin-amd64" then "f3c11a9525ede49839da4079444587dead76be79daad1b9c94e970bd97c377ce"
    when "darwin-arm64" then "efb7f79123fd41f792f28d39383aec0699389fa20952b50524496d84f8eb8521"
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

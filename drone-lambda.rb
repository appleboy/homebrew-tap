class DroneLambda < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-lambda"
  version "1.3.9"

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
    when "linux-amd64" then "f924e826df5649716a73d47b82405fcf68c3facff877b8376e117819857437b8"
    when "linux-arm64" then "937f54fb17b6ed9c3982cb42e9e7dd2ad5aca9b1be2e58f416c06ed5d870fd49"
    when "darwin-amd64" then "066774caf65773874f5f59da4948c633f1d473e60557ef6cac42901b864c4ff2"
    when "darwin-arm64" then "dd3f1c11b8be8504a07c75a378eea7098959da0d9154aed97be1e3dc2973f716"
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

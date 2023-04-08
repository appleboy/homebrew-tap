class DroneLambda < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-lambda"
  version "1.3.6"

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
    when "linux-amd64" then "a24b82c7cfe0a3c59f95ef2f178be6fa3c0e23d5065071962cbc25dcc08f0087"
    when "linux-arm64" then "1102555a54f70475ee73e1681df5d1fe9f1cbd31e7ec86032ba122b8f46cd71b"
    when "darwin-amd64" then "19e8a367530f06ee0c988ef3c82ceae98d07ec3f78374296b22254e845f2be89"
    when "darwin-arm64" then "b1a0a5c6bbbd921d289170738cc0324886d24d330ce60e102d8deff91ab1add8"
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

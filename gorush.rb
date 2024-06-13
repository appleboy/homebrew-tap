class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.2"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "gorush: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "gorush-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/gorush/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "1be961abd4200f9b02ffee5dab76fab16988c112a189ea42c0685f5ee30774ae"
    when "linux-arm64" then "06b10cd7065b656cf2941e7fe4194e49c64dee7d81243e140bd2684113084689"
    when "darwin-amd64" then "4dc80c5faa759302f9a57908690c8b279ceaffcf6331a9ebb96af7fee0712f6b"
    when "darwin-arm64" then "eac61e349c46d282cb60151416d0ea8499fbc813aa651125467913f36245cb88"
    else
      raise "gorush: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "git"
  depends_on "zsh" => :optional

  def install
    filename = Gorush.class_variable_get("@@filename")
    bin.install filename => "gorush"
  end

  test do
    system "#{bin}/gorush", "--version"
  end
end

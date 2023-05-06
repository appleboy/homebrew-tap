class DroneScp < Formula
  desc "Execute commands on a remote host through SSH"
  homepage "https://github.com/appleboy/drone-scp"
  version "1.6.11"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "drone-scp: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "drone-scp-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/drone-scp/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "e51c46680215076078499de62b287a378e02e3534dca0346abf785a353e37e0c"
    when "linux-arm64" then "0ea28e855c0e839518545c81d3949325b08d5f63565aeb9b2ed7f5cbab92c1b7"
    when "darwin-amd64" then "44b278cd8a46dae91c3d16d5e499deb523efa1c80d23c22ba277517ba4d0a980"
    when "darwin-arm64" then "d2f2e85858cc67473219f1f51d8a5b74cbf0f3071e812553cc435799c4011035"
    else
      raise "drone-scp: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = DroneScp.class_variable_get("@@filename")
    bin.install filename => "drone-scp"
  end

  test do
    system "#{bin}/drone-scp", "version"
  end
end

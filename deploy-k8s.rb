class DeployK8s < Formula
  desc "Generate a Kubeconfig or creating & updating K8s Deployments."
  homepage "https://github.com/appleboy/deploy-k8s"
  version "0.0.3"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "deploy-k8s: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "deploy-k8s-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/deploy-k8s/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "20ebdbc5bcdbcbaefaedd5df2d4a02e5968cad49242251fec3aa8f1daad6b325"
    when "linux-arm64" then "7f3dcda8cda830a85e6d38c024863a7b9c9621b09aeeff758b390e3e9cc02781"
    when "darwin-amd64" then "f4bcf672d15095950a719ddb5d232b3482c41ade517ca4f7eac30bad2e04681f"
    when "darwin-arm64" then "5096f045b4ddfa5836a3c6314bc218d0885e8b20fcbf61a6f4fb75e778deb82d"
    else
      raise "deploy-k8s: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "zsh" => :optional

  def install
    filename = DeployK8s.class_variable_get("@@filename")
    bin.install filename => "deploy-k8s"
  end

  test do
    system "#{bin}/deploy-k8s", "version"
  end
end

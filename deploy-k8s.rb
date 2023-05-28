class DeployK8s < Formula
  desc "Generate a Kubeconfig or creating & updating K8s Deployments."
  homepage "https://github.com/appleboy/deploy-k8s"
  version "0.0.1"

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
    when "linux-amd64" then "561d39ef7d3b13e486edfbfd4809ba29134ed8980f0bf33c3e64f005f38bb52f"
    when "linux-arm64" then "3e760b7513fb9c0ca1f2419898b02417b596d0bcd181f9e58f065fe7e4530c47"
    when "darwin-amd64" then "55a530538f494c6e7a2575809ddda452d3c288fe2f5589ab8f7ed487b37726ed"
    when "darwin-arm64" then "d0b2124342aca7c9c06fb6af65c66781a885a0426f7f2ffc89785bed714c6808"
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

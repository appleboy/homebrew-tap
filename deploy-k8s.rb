class DeployK8s < Formula
  desc "Generate a Kubeconfig or creating & updating K8s Deployments."
  homepage "https://github.com/appleboy/deploy-k8s"
  version "0.0.2"

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
    when "linux-amd64" then "29416caa429d1b9b8327dbebf8dc2dddec0ab8ca7e8530ab534b938544528ada"
    when "linux-arm64" then "d74bf0c4cc1cf8b7f55863b5b517e7d5131f0d671b7fefa525b7ecdf76ea6190"
    when "darwin-amd64" then "2e69d2f4ae6d36d780aef01de7a23a0c659e8c39323223cb49b9b7293b6d7544"
    when "darwin-arm64" then "9329348d03f6f015e5ea39e2338742944a4ea807cde2e70dea59ffa10bb162b6"
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

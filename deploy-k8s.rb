class DeployK8s < Formula
  desc "Generate a Kubeconfig or creating & updating K8s Deployments."
  homepage "https://github.com/appleboy/deploy-k8s"
  version "0.0.4"

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
    when "linux-amd64" then "1939a9eaf74688d6a5e92a3bb64d87b16fe3e0894d684a375d9b4783cded0176"
    when "linux-arm64" then "5948611742f793d6fce40fa09f8f7e4f73c44db80db72a8c02a7ac566c282b57"
    when "darwin-amd64" then "a295c1e6cb659edea6731a2ce45008dcadd71e8e6e92c48097d9a9f6a02695b9"
    when "darwin-arm64" then "ed986550d116af3767aae5417a6aeb5fc4872b4071984b2991f05d396308ec0a"
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

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
    when "linux-amd64" then "5334bbce00e4dba4d3be53b081bb2cad796aafb58b450816516bfead3e22ff6f"
    when "linux-arm64" then "55ae895650b5212d23db47a0a1d8047f0216f0a016f76e72d17436a1a0964202"
    when "darwin-amd64" then "15bfa9c6baa586b980222435306d0cbb9104987f96cb609f5dca0652848cb43d"
    when "darwin-arm64" then "d68dbc66d2f80e4d61276d4f18484fcf35882c468fb4ef7cae4ce47e6179fdcf"
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

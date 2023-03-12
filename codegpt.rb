class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.0.7"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "CodeGPT: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "CodeGPT-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/CodeGPT/releases/download/#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "99d183d8bc36a0c9bed9ef5efc1f640e1e553367752e505621570ece614a9136"
    when "linux-arm64" then "6def3f20cc60d898a1a949516bac2caccbf180421d0f58fc3132c0b3bba769a4" # binary
    when "darwin-amd64" then "a415dea29c21dbc50cb6f77319a07ad76f9d722119b85277bc13aced06581a65"
    when "darwin-arm64" then "c5f3e7d3013e7857233afe3dc6a2b914513d22dfce9d7a4a07bb81965d986d4d"
    else
      raise "CodeGPT: Unsupported system #{os}-#{arch}"
    end

  sha256 @@sha256
  url @@url,
    using: @@using

  depends_on "git"
  depends_on "zsh" => :optional

  def install
    filename = Codegpt.class_variable_get("@@filename")
    bin.install filename => "codegpt"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "bash")
    (bash_completion/"codegpt").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "zsh")
    (zsh_completion/"_codegpt").write output
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end

class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.1.4"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "CodeGPT: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "CodeGPT-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/CodeGPT/releases/download/v#{version}/#{@@filename}"
  @@using = :nounzip

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "45b35e7ca6ba995cad4095947c0de251a2eeb541e7314a6e4e84f1dc0cb2ffd1"
    when "linux-arm64" then "8b03809f8f5c1dc5466785d3ce834d8ec40a1953ab62bf7d2b836b307bd4cdbf"
    when "darwin-amd64" then "c49090a82cda7b3d652a59aa7d698cdc02065631950479e317d4d0c63cad39d0"
    when "darwin-arm64" then "8672a28cc2d35452e08df2709a7c02a6b308c40e50db3f939eaf74766641bf68"
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
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end

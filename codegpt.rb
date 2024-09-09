class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.14.3"

  os = OS.mac? ? "darwin" : "linux"
  arch = case Hardware::CPU.arch
         when :x86_64 then "amd64"
         when :arm64 then "arm64"
         else
           raise "CodeGPT: Unsupported system architecture #{Hardware::CPU.arch}"
         end

  @@filename = "CodeGPT-#{version}-#{os}-#{arch}"
  @@url = "https://github.com/appleboy/CodeGPT/releases/download/v#{version}/#{@@filename}"
  @@url += ".xz"
  @@using = nil
  depends_on "xz"

  @@sha256 = case "#{os}-#{arch}"
    when "linux-amd64" then "7ee6985eed5564371a51f88b1ec1d06ba48e6e172a00a98b6e0e843835aadc1c"
    when "linux-arm64" then "d8177c08707f065138a50099be7fb5d3710ed9930d453b4ef3b4ebc71a87e16e"
    when "darwin-amd64" then "870bcf8109428267fc6687e214faa3bd7bc2b9a5b7a5578824e42fb8c50f74b1"
    when "darwin-arm64" then "49cdfd8680fbe7124dd564b3f1d1c6de790616ddd463a21e47f5f39fa3f9d6ca"
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

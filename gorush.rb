class Gorush < Formula
  desc "A push notification server written in Go (Golang)."
  homepage "https://github.com/appleboy/gorush"
  version "1.18.6"

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
    when "linux-amd64" then "ff3795ab017dead98bdf640360d78868a320edfb4535ed707fc19a07e525a3a8"
    when "linux-arm64" then "4009a14dcef214730036050678d1179f0660340c2e8b8465139598902c2dbd2d"
    when "darwin-amd64" then "0015c2fe9f8ff202e890c655157a9bc6ccc7787bd223c9fa9716ea9a94279758"
    when "darwin-arm64" then "c6cdf271da8f44238ac572a138d7cfa6a042c8f3035d55c70c018e43d824b2fc"
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

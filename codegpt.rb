class Codegpt < Formula
  desc "A CLI written in Go language that writes git commit messages for you using ChatGPT AI (gpt-3.5-turbo model) and automatically installs a git prepare-commit-msg hook."
  homepage "https://github.com/appleboy/CodeGPT"
  version "0.0.7"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/appleboy/CodeGPT/releases/download/v0.0.7/CodeGPT-0.0.7-darwin-amd64"
      sha256 "a415dea29c21dbc50cb6f77319a07ad76f9d722119b85277bc13aced06581a65"

      def install
        bin.install "codegpt"

        # Install bash completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "bash")
        (bash_completion/"codegpt").write output

        # Install zsh completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "zsh")
        (zsh_completion/"_codegpt").write output
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/appleboy/CodeGPT/releases/download/v0.0.7/CodeGPT-0.0.7-darwin-arm64"
      sha256 "c5f3e7d3013e7857233afe3dc6a2b914513d22dfce9d7a4a07bb81965d986d4d"

      def install
        bin.install "codegpt"

        # Install bash completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "bash")
        (bash_completion/"codegpt").write output

        # Install zsh completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "zsh")
        (zsh_completion/"_codegpt").write output
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/appleboy/CodeGPT/releases/download/v0.0.7/CodeGPT-0.0.7-linux-amd64"
      sha256 "99d183d8bc36a0c9bed9ef5efc1f640e1e553367752e505621570ece614a9136"

      def install
        bin.install "codegpt"

        # Install bash completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "bash")
        (bash_completion/"codegpt").write output

        # Install zsh completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "zsh")
        (zsh_completion/"_codegpt").write output
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/appleboy/CodeGPT/releases/download/v0.0.7/CodeGPT-0.0.7-linux-arm64"
      sha256 "6def3f20cc60d898a1a949516bac2caccbf180421d0f58fc3132c0b3bba769a4"

      def install
        bin.install "codegpt"

        # Install bash completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "bash")
        (bash_completion/"codegpt").write output

        # Install zsh completion
        output = Utils.safe_popen_read("#{bin}/codegpt", "completion", "zsh")
        (zsh_completion/"_codegpt").write output
      end
    end
  end

  depends_on "git"

  test do
    system "#{bin}/codegpt version"
  end
end

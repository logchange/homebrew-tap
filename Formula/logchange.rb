class Logchange < Formula
  desc "CLI tool for managing and generating CHANGELOG.md"
  homepage "https://github.com/logchange/logchange"
  version "1.19.10"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-linuxx64.zip"
    sha256 "429a52282ae6d2688143c61d4dec5609f3ee220958f52b5cc9e6868ac1eff362"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinarm64.zip"
    sha256 "3fe716cd659d4bf073a81d67930b7f2a97dacaedae032c288d15fb060464950c"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinx64.zip"
    sha256 "f3f3d8560e8a8a0b916f1493541822c8ec57ebd71849df660f462068984ca3bf"
  end

  def install
    libexec.install Dir["*"]
    os_arch = ""
    if OS.linux? && Hardware::CPU.intel?
      os_arch = "linuxx64"
    elsif OS.mac? && Hardware::CPU.arm?
      os_arch = "darwinarm64"
    elsif OS.mac? && Hardware::CPU.intel?
      os_arch = "darwinx64"
    else
      puts "Unsupported system or architecture!"
    end
    chmod 0755, "#{libexec}/logchange-#{os_arch}/logchange"
    bin.write_exec_script "#{libexec}/logchange-#{os_arch}/logchange"
  end

  test do
    output = shell_output("#{bin}/logchange --version")
    assert_match version.to_s, output
  end
end

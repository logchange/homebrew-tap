class Logchange < Formula
  desc "CLI tool for managing and generating CHANGELOG.md"
  homepage "https://github.com/logchange/logchange"
  version "1.19.3"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-linuxx64.zip"
    sha256 "66d57c17b57629ec6f0c072b7dac3af4d60ada1e4cfd4b8f626be79bad6a2313"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinarm64.zip"
    sha256 "f1d22299f3c1b8e0618ac5859426e50f7919df34e25a03cd36ff08544b70f4ed"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinx64.zip"
    sha256 "697f8db9bbc2ee030ba37a1016405c585d9ee17361d3db2b2aab6529fd6d6212"
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

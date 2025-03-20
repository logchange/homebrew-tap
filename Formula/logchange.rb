class Logchange < Formula
  desc "CLI tool for managing and generating CHANGELOG.md"
  homepage "https://github.com/logchange/logchange"
  version "1.18.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-linuxx64.zip"
    sha256 "e7fe3d1569d67684826e0842c4ce4de9389fdafdb369f3be49402e741e48d103"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinarm64.zip"
    sha256 "75de2307789616f8eaf24b95037c186a4028392a185ed84ee4758e3b511e60cd"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinx64.zip"
    sha256 "97d738211b6abe0de7bb9928a4cc46fe9c6d69d70bcaec9d64b1d06c5039e0b6"
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

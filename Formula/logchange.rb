class Logchange < Formula
  desc "CLI tool for managing and generating CHANGELOG.md"
  homepage "https://github.com/logchange/logchange"
  version "1.16.8"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-linuxx64.zip"
    sha256 "585f51bcbf34300e2f314f5e32996af25ae6643070a83afb38d7aff023763f97"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinarm64.zip"
    sha256 "916232675130851b862f6fd6d5455658d596f25a8e424c777364f4f119d02a6a"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinx64.zip"
    sha256 "65e651b779359327c3d260807098b022ca5ba0eb997c64a319ac1da0e817e314"
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
end

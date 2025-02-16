class Logchange < Formula
  desc "CLI tool for managing and generating CHANGELOG.md"
  homepage "https://github.com/logchange/logchange"
  version "1.16.10"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-linuxx64.zip"
    sha256 "278713832bec168a5e0766f37ec0bf0d7455a689057719bfa46bef11f9213322"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinarm64.zip"
    sha256 "f14895ce834fca169faa4bf1ca646dd2344e40df7abeb40b6133206232352ca0"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/logchange/logchange/releases/download/#{version}/logchange-darwinx64.zip"
    sha256 "7080b80abcfeeb8845e453e22fb88dd9061ea74f9e26c76fb8251fb32570352b"
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

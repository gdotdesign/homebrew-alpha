class Muon < Formula
  desc "Modern low-level programming language"
  homepage "https://github.com/nickmqb/muon"
  head "https://github.com/nickmqb/muon.git"

  def install
    cd "bootstrap" do
      system ENV.cc, "-O3", "-o", "mu", "mu.c"
      libexec.install "mu"
    end
    libexec.install "lib"
    pkgshare.install "examples"
    bin.install_symlink libexec/"mu"
  end

  test do
    cp_r pkgshare/"examples/.", testpath
    system bin/"mu", libexec/"lib/core.mu", "hello_world.mu", "--output-file", "hello_world.c"
    system ENV.cc, "-o", "hello_world", "hello_world.c"
    assert_match "Hello from Muon!", shell_output("./hello_world")
  end
end

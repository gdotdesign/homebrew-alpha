class Odin < Formula
  desc "Simple, high-performance programming language built for modern systems"
  homepage "https://odin-lang.org/"
  head "https://github.com/odin-lang/Odin.git"

  depends_on "llvm"

  def install
    system "make", "release"
    libexec.install "core", "odin", "shared"
    bin.install_symlink libexec/"odin"
  end

  test do
    (testpath/"hello.odin").write <<~EOS
      package main
      import "core:fmt"
      main :: proc() {
        fmt.println("Hello, world!");
      }
    EOS
    system bin/"odin", "build", "hello.odin", "-out:hello"
    assert_equal "Hello, world!", shell_output("./hello").chomp
  end
end

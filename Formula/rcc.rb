class Rcc < Formula
  desc "C compiler written in Rust, with a focus on good error messages"
  homepage "https://github.com/jyn514/rcc"
  url "https://github.com/jyn514/rcc/archive/0.8.0.tar.gz"
  sha256 "706d69749838b913201ec5243b2bd50ff3880dc1d10ab0f23509bbee8bc4ca04"
  head "https://github.com/jyn514/rcc.git"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    (testpath/"hello.c").write <<-EOS
      int printf(const char *, ...);
      int main() {
        printf("Hello, world!\\n");
      }
    EOS
    system bin/"rcc", "-o", "test", "hello.c"
    assert_match "Hello, world!", shell_output("./test")
  end
end

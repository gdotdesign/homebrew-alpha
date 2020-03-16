class Never < Formula
  desc "Statically typed, embedded functional programming language"
  homepage "https://never-lang.readthedocs.io/"
  head "https://github.com/never-lang/never.git"

  depends_on "cmake" => :build
  depends_on "bison"
  depends_on "flex"
  depends_on "libffi"
  depends_on :linux

  def install
    libffi = Formula["libffi"]
    ENV.prepend "CFLAGS", "-I#{libffi.opt_lib}/libffi-#{libffi.version}/include"
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      bin.install "never"
    end
  end

  test do
    (testpath/"hello.nev").write <<-EOS
      func main() -> int
      {
        prints("Hello World!\\n");
        0
      }
    EOS
    assert_match "Hello World!", shell_output("#{bin}/never -f hello.nev")
  end
end

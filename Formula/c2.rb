class C2 < Formula
  desc "New programming language strongly based on C"
  homepage "http://c2lang.org/"
  head "https://github.com/c2lang/c2compiler.git"

  depends_on "cmake" => :build
  depends_on "llvm"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install", "DESTDIR=#{libexec}"
    end
    libexec.install "c2libs"
    bin.install_symlink libexec/"c2tags"
    (bin/"c2c").write_env_script opt_libexec/"c2c", :C2_LIBDIR => opt_libexec/"c2libs"
  end

  test do
    (testpath/"hello.c2").write <<-EOS
      module hello_world;
      import stdio local;
      public func i32 main(i32 argc, i8*[] argv) {
        printf("Hello World!\\n");
        return 0;
      }
    EOS
    system "#{bin}/c2c", "-c", "-f", "hello.c2"
    assert_match "Hello World!", shell_output("./output/dummy/dummy")
  end
end

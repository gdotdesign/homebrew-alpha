class Ravi < Formula
  desc "Derivative of Lua with limited optional static typing and JIT compilation"
  homepage "https://github.com/dibyendumajumdar/ravi"
  url "https://github.com/dibyendumajumdar/ravi/archive/1.0-beta3.tar.gz"
  sha256 "4eb936dff0ea4e03d7cb35a305cd1b4224e575e7df31378b7cc141d4b7c9c91a"
  head "https://github.com/dibyendumajumdar/ravi.git"

  bottle do
    root_url "https://dl.bintray.com/homebrew-community/bottles-alpha"
    cellar :any
    sha256 "06f1dabe5a021c604a0892c3b89c7e57998c8f9f4e91c7f22b03801254622a85" => :catalina
  end

  depends_on "cmake" => :build
  depends_on "llvm" => :recommended

  def install
    args = std_cmake_args
    args << "-DLLVM_JIT=ON" if build.with? "llvm"
    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    (testpath/"hello.ravi").write <<~EOS
      local message: string = "Hello, world!"
      print(message)
    EOS
    assert_match "Hello, world!", shell_output("#{bin}/ravi hello.ravi")
  end
end

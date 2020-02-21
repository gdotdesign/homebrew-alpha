class Vlang < Formula
  desc "Simple, fast, safe, compiled language"
  homepage "https://vlang.io/"

  head do
    url "https://github.com/vlang/v.git"

    resource "vc" do
      url "https://github.com/vlang/vc.git"
    end
  end

  def install
    resource("vc").stage do
      system ENV.cc, "-std=gnu11", "-w", "-o", "v", "v.c", "-lm"
      libexec.install "v"
    end
    libexec.install "cmd", "examples", "thirdparty", "vlib"
    bin.install_symlink libexec/"v"
  end

  test do
    cp libexec/"examples/hello_world.v", testpath
    system "#{bin}/v", "-o", "test", "hello_world.v"
    assert_equal "Hello, World!", shell_output("./test").chomp
  end
end

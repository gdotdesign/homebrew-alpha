VERSION = "0.1.24".freeze

class Vlang < Formula
  desc "Simple, fast, safe, compiled programming language"
  homepage "https://vlang.io/"

  stable do
    if OS.mac?
      url "https://github.com/vlang/v/releases/download/#{VERSION}/v_macos.zip"
      sha256 "9b5a98aa82812b9dbf28e19d1199fdc6799098378ccec98f217d935c7fbd6b1d"
    elsif OS.linux?
      url "https://github.com/vlang/v/releases/download/#{VERSION}/v_linux.zip"
      sha256 "b8dff67f872562ec6ffd9031e3f540e1c06b3e63acd1e1f1032e3dbac94323dd"
    end
  end

  head do
    url "https://github.com/vlang/v.git"

    resource "vc" do
      url "https://github.com/vlang/vc.git"
    end
  end

  def install
    unless build.stable?
      resource("vc").stage do
        system ENV.cc, "-std=gnu11", "-w", "-o", "v", "v.c", "-lm"
        libexec.install "v"
      end
    end
    libexec.install Dir["*"]
    bin.install_symlink libexec/"v"
  end

  test do
    cp libexec/"examples/hello_world.v", testpath
    system "#{bin}/v", "-o", "test", "hello_world.v"
    assert_equal "Hello, World!", shell_output("./test").chomp
  end
end

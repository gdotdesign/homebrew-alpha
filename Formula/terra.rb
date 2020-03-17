VERSION = "1.0.0-beta1".freeze
REVISION = "2e2032e45063eac60811e9354b6996d0a96b2858".freeze
REVISION_SHORT = REVISION[0...7].freeze

class Terra < Formula
  desc "Low-level programming language embedded in and meta-programmed by Lua"
  homepage "http://terralang.org/"

  stable do
    if OS.mac?
      url "https://github.com/terralang/terra/releases/download/release-#{VERSION}/terra-OSX-x86_64-#{REVISION_SHORT}.zip"
      version VERSION
      sha256 "0dee25df54193d9368e0e82da0318efa2ffbf901a7ca4e7717ce699e9d929f5f"
    elsif OS.linux?
      if Hardware::CPU.intel?
        url "https://github.com/terralang/terra/releases/download/release-#{VERSION}/terra-Linux-x86_64-#{REVISION_SHORT}.zip"
        version VERSION
        sha256 "62bee805fd1b162fb928204761a183a045253b60f8d74f2a8e68cc2afbb45ab2"
      end
    end
  end

  devel do
    url "https://github.com/terralang/terra.git",
        :tag      => "release-#{VERSION}",
        :revision => REVISION
  end

  head do
    url "https://github.com/terralang/terra.git"
  end

  unless build.stable?
    resource "getluajit" do
      url "https://github.com/SeekingMeaning/terra/raw/b54d94e/cmake/Modules/GetLuaJIT.cmake"
      sha256 "c0e7400a5154ff0194679e0c7a8dd2dacadf80a2bcd0d6a8e24452245a39b8e9"
    end
  end

  depends_on "cmake" => :build unless build.stable?
  depends_on build.head? ? "llvm@9" : "llvm@6"
  depends_on "luajit"

  def install
    if build.stable?
      prefix.install "bin", "include", "lib", "share"
    else
      (buildpath/"cmake/Modules").install resource("getluajit")
      cd "build" do
        system "cmake", "..", "-DLUAJIT_INSTALL_PREFIX=#{Formula["luajit"].opt_prefix}", *std_cmake_args
        system "make", "install"
      end
    end
  end

  test do
    sdk_path = MacOS::CLT.installed? ? "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" : MacOS.sdk_path
    (testpath/"hello.t").write <<~EOS
      function printhello()
          print("Hello, Lua!")
      end
      terralib.includepath = "/usr/include;/usr/local/include;#{sdk_path}/usr/include"
      C = terralib.includec("stdio.h")
      terra hello(argc : int, argv : &rawstring)
          C.printf("Hello, Terra!\\n")
          return 0
      end
      printhello()
      hello(0,nil)
    EOS
    output = shell_output("#{bin}/terra hello.t")
    assert_match("Hello, Lua!", output)
    assert_match("Hello, Terra!", output)
  end
end

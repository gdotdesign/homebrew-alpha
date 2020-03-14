class Oil < Formula
  desc "New Unix shell"
  homepage "https://www.oilshell.org/"
  url "https://www.oilshell.org/download/oil-0.8.pre2.tar.xz"
  sha256 "671dccc73804c37b709d1cc203202957c631c8173052280083dad389514ed79f"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "./install"
  end

  test do
    (testpath/"hello.sh").write <<~EOS
      #!/bin/bash
      echo Hello, world!
    EOS
    assert_equal "Hello, world!", shell_output("#{bin}/osh hello.sh").chomp
  end
end

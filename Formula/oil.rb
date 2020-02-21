class Oil < Formula
  desc "New Unix shell"
  homepage "https://www.oilshell.org/"
  url "https://www.oilshell.org/download/oil-0.8.pre1.tar.xz"
  sha256 "d42de21c3076aa7a93ebbe8e2026ea6f9fd4d5097130272365d1e42103f70fea"

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

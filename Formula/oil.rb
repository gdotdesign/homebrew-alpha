class Oil < Formula
  desc "New Unix shell"
  homepage "https://www.oilshell.org/"
  url "https://www.oilshell.org/download/oil-0.8.pre3.tar.xz"
  sha256 "70ddfad74dc55b3bbf2c6a5832bd9de5c38d759e4b699b1acad42cf5b07d3362"

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

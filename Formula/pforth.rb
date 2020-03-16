class Pforth < Formula
  desc "Portable ANS-like Forth written in ANSI C"
  homepage "http://www.softsynth.com/pforth/"
  url "https://github.com/philburk/pforth/archive/12fb261689756b5a3b6d4d4b4a9a8adee301beba.tar.gz"
  version "28"
  sha256 "925b7500e49fd5d52f683b5b84fd105fcabe6487ba54e3eb92846d45bd913ce8"
  head "https://github.com/philburk/pforth.git"

  def install
    cd "build/unix" do
      system "make", "pfdicapp"
      system "make", "pfdicdat"
      system "make", "pforthapp"
      bin.install "pforth_standalone" => "pforth"
    end
  end

  test do
    (testpath/"hello.fth").write <<~EOS
      CR ." HELLO WORLD"
    EOS
    assert_match "HELLO WORLD", shell_output("#{bin}/pforth hello.fth")
  end
end

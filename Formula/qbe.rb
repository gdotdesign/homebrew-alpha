class Qbe < Formula
  desc "Small, pure C embeddable compiler backend"
  homepage "https://c9x.me/compile/"
  head "git://c9x.me/qbe.git"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.ssa").write <<-EOS
      function w $add(w %a, w %b) {          # Define a function add
      @start
        %c =w add %a, %b                   # Adds the 2 arguments
        ret %c                             # Return the result
      }
      export function w $main() {            # Main function
      @start
        %r =w call $add(w 1, w 1)          # Call add(1, 1)
        call $printf(l $fmt, w %r, ...)    # Show the result
        ret 0
      }
      data $fmt = { b "One and one make %d!\\n", b 0 }
    EOS
    system "#{bin}/qbe", "-o", "test.s", "test.ssa"
    system ENV.cc, "-o", "test", "test.s"
    assert_match "One and one make 2!", shell_output("./test")
  end
end

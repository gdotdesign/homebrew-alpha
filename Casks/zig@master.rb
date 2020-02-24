require 'open-uri'

releases = JSON.load(open("https://ziglang.org/download/index.json"))
sha256 = releases["master"]["x86_64-macos"]["shasum"]
url = releases["master"]["x86_64-macos"]["tarball"]
# e.g. zig-macos-x86_64-0.5.0+d1243bf27
m = /-((?:\d+\.)*\d+\.\d+\+[a-fA-F0-9]{9})/.match(url)
version = m.captures.first

cask 'zig@master' do
  version version
  sha256 sha256

  url url
  name 'Zig'
  homepage 'https://ziglang.org/'

  conflicts_with formula: 'zig', # conflicts_with formula: is not yet functional
                 cask: 'zig'

  binary "zig-macos-x86_64-#{version}/zig"
end

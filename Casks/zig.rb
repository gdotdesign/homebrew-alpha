cask 'zig' do
  version '0.5.0'
  sha256 '28702cc05745c7c0bd450487d5f4091bf0a1ad279b35eb9a640ce3e3a15b300d'

  url "https://ziglang.org/download/#{version}/zig-macos-x86_64-#{version}.tar.xz"
  name 'Zig'
  homepage 'https://ziglang.org/'

  conflicts_with formula: 'zig', # conflicts_with formula: is not yet functional
                 cask: 'zig@master'

  binary "zig-macos-x86_64-#{version}/zig"
end

cask 'zig' do
  version '0.5.0'

  if OS.mac?
    sha256 '28702cc05745c7c0bd450487d5f4091bf0a1ad279b35eb9a640ce3e3a15b300d'
    url "https://ziglang.org/download/#{version}/zig-macos-x86_64-#{version}.tar.xz"
  elsif OS.linux?
    if Hardware::CPU.intel?
      sha256 '43e8f8a8b8556edd373ddf9c1ef3ca6cf852d4d09fe07d5736d12fefedd2b4f7'
      url "https://ziglang.org/download/#{version}/zig-linux-x86_64-#{version}.tar.xz"
    end
  end

  name 'Zig'
  homepage 'https://ziglang.org/'

  conflicts_with formula: 'zig',
                 cask:    'zig-master'
  depends_on formula: 'llvm'

  if OS.mac?
    binary "zig-macos-x86_64-#{version}/zig"
  elsif OS.linux?
    if Hardware::CPU.intel?
      binary "zig-linux-x86_64-#{version}/zig"
    end
  end
end

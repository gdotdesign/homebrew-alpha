require 'open-uri'

cpu = nil
os = nil
if OS.mac?
  cpu = 'x86_64'
  os = 'macos'
elsif OS.linux?
  if Hardware::CPU.intel?
    cpu = 'x86_64'
    os = 'linux'
  elsif Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      cpu = 'aarch64'
      os = 'linux'
    end
  end
end

releases = JSON.load(open('https://ziglang.org/download/index.json'))
sha256 = releases['master']["#{cpu}-#{os}"]['shasum']
url = releases['master']["#{cpu}-#{os}"]['tarball']
# e.g. zig-macos-x86_64-0.5.0+d1243bf27
m = %r{-((?:\d+\.)*\d+\.\d+\+[a-fA-F0-9]{9})}.match(url)
v = m.captures.first

cask 'zig-master' do
  version :latest
  sha256 sha256

  url url
  name 'Zig'
  homepage 'https://ziglang.org/'

  conflicts_with formula: 'zig',
                 cask:    'zig'
  depends_on formula: 'llvm'

  binary "zig-#{os}-#{cpu}-#{v}/zig"
end

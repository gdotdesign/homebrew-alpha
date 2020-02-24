cask 'mint-lang' do
  version '0.7.1'
  sha256 '5913f26524ffffeebdaa817c4e068e5dde3de6779e1631043aa1b18707bdf6a4'

  url "https://github.com/mint-lang/mint/releases/download/#{version}/mint-#{version}-osx"
  appcast 'https://github.com/mint-lang/mint/releases.atom'
  name 'Mint'
  homepage 'https://www.mint-lang.com/'

  conflicts_with formula: 'mint-lang'

  binary "mint-#{version}-osx", target: 'mint'
end

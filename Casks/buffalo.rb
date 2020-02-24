cask 'buffalo' do
  version '0.15.5'
  if OS.mac?
    url "https://github.com/gobuffalo/buffalo/releases/download/v#{version}/buffalo_#{version}_Darwin_x86_64.tar.gz"
    sha256 "d843396151a98e9a9724d7a42448d8cfffe87809692a5443abeff7288b1ec231"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/gobuffalo/buffalo/releases/download/v#{version}/buffalo_#{version}_Linux_x86_64.tar.gz"
      sha256 "5bb92e070d3c8633fb0be5bd20698dd07c73272a16d80699deecd63d9f450697"
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/gobuffalo/buffalo/releases/download/v#{version}/buffalo_#{version}_Linux_arm64.tar.gz"
        sha256 "4b65f7b66fa22ee4e200031650a14f656cf466afae8219e1422dfd80915e3256"
      else
        url "https://github.com/gobuffalo/buffalo/releases/download/v#{version}/buffalo_#{version}_Linux_armv6.tar.gz"
        sha256 "77e61616cb5e645c7b20838651c0629c8a1b09e5416641bc2e1c73572487b257"
      end
    end
  end
  appcast 'https://github.com/gobuffalo/buffalo/releases.atom'
  name 'Buffalo'
  homepage 'http://gobuffalo.io/'

  binary 'buffalo'
end

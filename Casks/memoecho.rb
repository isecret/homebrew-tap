cask "memoecho" do
  version "1.0.0-beta.31"
  sha256 "5bb1243c13517824d7c12e7c2aeeb33447156c67f7938eaf9b8ad2abd3900949"

  url "https://github.com/isecret/MemoEcho/releases/download/v#{version}/MemoEcho-v#{version}.dmg"
  name "MemoEcho"
  desc "Menu bar voice input assistant with AI text polishing and translation"
  homepage "https://memoecho.app/"

  livecheck do
    url "https://raw.githubusercontent.com/isecret/MemoEcho/main/updates/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sonoma

  app "MemoEcho.app"
end

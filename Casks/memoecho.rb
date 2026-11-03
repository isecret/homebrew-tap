cask "memoecho" do
  version "1.0.0-beta.25"
  sha256 "45c4c6b4ee17a758beaf42fa23701534e76521caaa4e40a3ff5d33cdf11d8029"

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

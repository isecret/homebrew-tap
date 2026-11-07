cask "memoecho" do
  version "1.0.0-beta.27"
  sha256 "a75f15b9d8a221dc15439a108330e91387045f9e6bbf298aad5b1f515721f140"

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

cask "memoecho" do
  version "1.0.0-beta.19"
  sha256 "67a8c7f869d395f5f891b27b7bf0cd7b1faf6a3aad40e5a73d5cc61df64b9a74"

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

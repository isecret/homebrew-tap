cask "memoecho" do
  version "1.0.0-beta.16"
  sha256 "03c80a1d745fed5bbca0bb9f2e7f16681814fa1c678dfacceeec419a098c948b"

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

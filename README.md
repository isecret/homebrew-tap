# isecret Homebrew Tap

通过 Homebrew 安装 [MemoEcho](https://github.com/isecret/MemoEcho)：macOS 菜单栏语音输入助手，支持语音识别、AI 润色与翻译。

## 安装

```bash
brew install --cask isecret/tap/memoecho
```

如果 Homebrew 提示需要信任第三方 Cask，先执行：

```bash
brew tap isecret/tap
brew trust --cask isecret/tap/memoecho
brew install --cask isecret/tap/memoecho
```

`brew trust` 适用于支持该命令的新版 Homebrew；旧版无需执行。

- 要求 macOS 14 或更高版本，支持 Apple Silicon 和 Intel。
- 当前跟随 MemoEcho 发布渠道，包含 beta 测试版；安装前可查看[发布说明](https://github.com/isecret/MemoEcho/releases)。
- 安装包直接下载自 MemoEcho GitHub Releases，Cask 校验 SHA-256。
- 首次使用仍需在应用内授予麦克风、辅助功能权限并配置语音与 AI 服务。
- 已手动安装同版本的用户，可以在退出应用后尝试 `brew install --cask --adopt isecret/tap/memoecho`；不要使用 `--force` 覆盖仍在运行的应用。

## 更新

MemoEcho 支持应用内自动更新。通过 Homebrew 主动检查并更新：

```bash
brew update
brew upgrade --cask --greedy isecret/tap/memoecho
```

`--greedy` 会包含声明了应用内自动更新的 Cask。

## 卸载

先退出 MemoEcho，再运行：

```bash
brew uninstall --cask memoecho
```

普通卸载保留 `~/.memoecho` 中的配置和模型；本 Tap 不提供自动删除个人数据的 `zap` 操作。

## 维护

- `Casks/memoecho.rb` 为安装定义。
- `scripts/update_cask.py` 检查最新发布（包括 beta），下载 DMG 并校验 GitHub 提供的摘要后更新版本与 SHA-256。
- GitHub Actions 每天检查一次；也可手动运行 **Update MemoEcho** 工作流。
- 新版本应使用新 tag 和新附件，不覆盖已发布版本的安装包。
- 工作流只写入本仓库，使用仓库自带的 `GITHUB_TOKEN`，不需要 MemoEcho 主仓库的跨仓库写入凭据。

本仓库为项目维护者提供的第三方 Tap，并非 Homebrew 官方收录。

# dotfiles

M4 Mac (Apple Silicon) 向けに最適化された開発環境設定ファイル

## クイックスタート（新規Mac）

```bash
# 1. Xcode Command Line Toolsをインストール
xcode-select --install

# 2. Homebrewをインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Homebrew PATHを設定（M4 Mac用）
eval "$(/opt/homebrew/bin/brew shellenv)"

# 4. Gitをインストール
brew install git

# 5. dotfilesをクローン
git clone https://github.com/ho2ri2s/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 6. インストールスクリプトを実行
chmod +x install.sh install-mac.sh
./install.sh

# 7. シェルを再起動
exec zsh
```

## セットアップ内容

`install.sh` を実行すると、以下が自動的にセットアップされます：

### シェル・ターミナル
- `.zshrc` → `~/.zshrc`
- `.profile` → `~/.profile`
- `starship.toml` → `~/.config/starship.toml`
- iTerm2設定 → `~/Library/Preferences/`

### 開発ツール
- `.gitconfig` → `~/.gitconfig`
- `.vimrc` → `~/.vimrc`
- `.ideavimrc` → `~/.ideavimrc`

### VSCode
- `settings.json` → VSCode User設定
- `keybindings.json` → VSCode キーバインド
- 拡張機能の自動インストール

### Android Studio
- カスタムキーマップのコピー
- プラグインは手動インストール

### Claude Code
- `settings.json` → `~/.claude/settings.json`
- `CLAUDE.md` → `~/.claude/CLAUDE.md`

### Node.js/npm
- `.npmrc` → `~/.npmrc`
- Node.js LTS の自動インストール（nvm経由）
- グローバルパッケージの自動インストール

### Homebrew
- `Brewfile` → `~/Brewfile`
- `brew bundle --global` で全パッケージインストール

## ファイル構成

```
dotfiles/
├── .claude/
│   ├── settings.json           # Claude Code フック設定（プロジェクトレベル）
│   └── settings.local.json     # Claude Code 権限設定（プロジェクトレベル）
├── claude/                     # Claude Code グローバル設定
│   ├── settings.json           # メイン設定（権限・プラグイン等）
│   └── CLAUDE.md               # グローバル指示
├── .config/
│   └── starship.toml           # Starship プロンプト設定
├── iterm2/
│   └── com.googlecode.iterm2.plist  # iTerm2設定
├── vscode/                     # VSCode設定
│   ├── settings.json           # エディタ設定
│   ├── keybindings.json        # キーバインド
│   └── extensions.txt          # 拡張機能リスト
├── android-studio/             # Android Studio設定
│   ├── keymaps/
│   │   └── custom-keymap.xml   # カスタムキーマップ
│   └── plugins.txt             # プラグインリスト
├── node/                       # Node.js/npm設定
│   ├── .nvmrc                  # 推奨Node.jsバージョン
│   ├── .npmrc                  # npm設定
│   └── global-packages.txt     # グローバルパッケージ
├── .gitconfig                  # Git設定
├── .ideavimrc                  # IntelliJ IDEA Vim設定
├── .profile                    # 開発環境のPATH設定
├── .vimrc                      # Vim設定
├── .zshrc                      # Zsh設定
├── Brewfile                    # Homebrewパッケージリスト
├── install.sh                  # メインセットアップスクリプト
├── install-mac.sh              # macOS固有セットアップ
├── export-settings.sh          # 設定エクスポートスクリプト
└── README.md
```

## 設定の更新

設定を変更した後、dotfilesに反映するには：

```bash
cd ~/dotfiles
./export-settings.sh
git add -A
git commit -m "Update settings"
git push
```

## VSCode拡張機能

以下の拡張機能が自動インストールされます：

- `anthropic.claude-code` - Claude Code
- `dart-code.dart-code` - Dart
- `dart-code.flutter` - Flutter
- `github.copilot` - GitHub Copilot
- `github.copilot-chat` - GitHub Copilot Chat
- `github.vscode-pull-request-github` - GitHub Pull Request
- `google.geminicodeassist` - Google Gemini Code Assist
- `ms-vscode.makefile-tools` - Makefile Tools
- `vscodevim.vim` - Vim

## Android Studioプラグイン（手動インストール）

以下のプラグインを `Preferences > Plugins > Marketplace` からインストール：

- Dart
- Flutter
- IdeaVIM

## 個別セットアップが必要なツール

### Python (pyenv)
```bash
pyenv install 3.12.0
pyenv global 3.12.0
```

### Ruby (rbenv)
```bash
rbenv install 3.3.0
rbenv global 3.3.0
```

### Go (goenv)
```bash
goenv install 1.22.0
goenv global 1.22.0
```

### Flutter
```bash
git clone https://github.com/flutter/flutter.git ~/flutter
# シェルを再起動すると自動的にPATHに追加されます
```

### Alfred
```bash
# Alfred > Preferences > Advanced > Syncing
# Sync folder: ~/Dropbox/Alfred を設定
```

## インストールされるアプリケーション（Brewfile）

### 開発ツール
- git, gh, lazygit
- vim, fzf, peco
- tree, wget, cloc, plantuml

### プログラミング言語
- Go + goenv
- Ruby + rbenv
- OpenJDK 17
- uv (Python)

### モバイル開発
- CocoaPods

### アプリケーション
- Alfred
- Claude Code
- Dropbox
- Figma
- Google Chrome
- iTerm2
- JetBrains Toolbox
- Notion
- Slack
- Visual Studio Code
- Zoom

## Apple Silicon (M4) 対応

- 自動的なHomebrew PATH設定（`/opt/homebrew`）
- 条件付き環境変数（ツールの存在確認後に設定）
- Intel Macでも動作

## トラブルシューティング

### コマンドが見つからない場合
```bash
exec zsh
echo $PATH
```

### VSCode拡張機能がインストールされない場合
VSCodeで `Cmd+Shift+P` → `Shell Command: Install 'code' command in PATH` を実行

### Android Studioバージョン更新後
`./install.sh` を再実行するとキーマップが再コピーされます

### zplugが初回起動時にインストールされない場合
```bash
source ~/.zshrc
```

## ライセンス

MIT

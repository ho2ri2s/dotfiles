# dotfiles

M4 Mac (Apple Silicon) 向けに最適化された開発環境設定ファイル

## セットアップ手順

### 1. Homebrewのインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

インストール後、指示に従ってPATHを設定してください（M4では `/opt/homebrew` が使用されます）

### 2. このリポジトリのクローン

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

### 3. パッケージとアプリケーションのインストール

```bash
brew bundle
```

これにより、Brewfileに記載されている全てのツールとアプリケーションがインストールされます。

### 4. dotfilesのシンボリックリンク作成

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.profile ~/.profile
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
```

iTerm2の設定:
```bash
# iTerm2の設定を読み込む（iTerm2 > Preferences > General > Preferences）
# "Load preferences from a custom folder or URL" にチェックを入れて
# ~/dotfiles/iterm2 を指定
```

### 5. シェルの再起動

```bash
exec zsh
```

## インストールされるツール

### 開発ツール
- **git** - バージョン管理
- **gh** - GitHub CLI
- **lazygit** - Git用ターミナルUI
- **vim** - テキストエディタ
- **tree** - ディレクトリツリー表示
- **peco** - インタラクティブフィルタリング
- **wget** - ファイルダウンローダー
- **cloc** - コード行数カウンター
- **plantuml** - UML図生成

### プログラミング言語・ランタイム
- **Go** + **goenv** (バージョン管理)
- **Ruby** + **rbenv** (バージョン管理)
- **Node.js** (nvm経由)
- **Python** (pyenv経由)
- **OpenJDK 17**

### モバイル開発
- **CocoaPods** - iOS依存関係管理

### アプリケーション
- Alfred
- Background Music
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

## 個別セットアップが必要なツール

以下のツールは必要に応じて個別にセットアップしてください：

### Node.js (nvm)
```bash
# 最新LTSをインストール
nvm install --lts
nvm use --lts
```

### Python (pyenv)
```bash
# 最新安定版をインストール
pyenv install 3.12.0
pyenv global 3.12.0
```

### Ruby (rbenv)
```bash
# 最新安定版をインストール
rbenv install 3.3.0
rbenv global 3.3.0
```

### Go (goenv)
```bash
# 最新安定版をインストール
goenv install 1.22.0
goenv global 1.22.0
```

### Android Development
Android Studioをインストール後、`.profile`のANDROID_HOME設定が自動的に有効になります。

### Flutter
Flutterを使用する場合：
```bash
git clone https://github.com/flutter/flutter.git ~/flutter
# シェルを再起動すると自動的にPATHに追加されます
```

## ファイル構成

```
dotfiles/
├── .config/
│   └── starship.toml      # Starship プロンプト設定（実体）
├── iterm2/
│   └── com.googlecode.iterm2.plist  # iTerm2設定
├── .gitconfig             # Git設定
├── .profile               # 開発環境のPATH設定
├── .vimrc                 # Vim設定
├── .zshrc                 # Zsh設定
├── Brewfile               # Homebrewパッケージリスト
├── starship.toml          # Starship設定へのシンボリックリンク
└── README.md              # このファイル
```

## Apple Silicon (M4) 対応について

このdotfilesはApple Silicon (M1/M2/M3/M4) に最適化されています：

- **自動的なHomebrew PATH設定**: `.zshrc`がアーキテクチャを自動検出し、適切なパス（`/opt/homebrew` または `/usr/local`）を設定
- **条件付き環境変数**: `.profile`で各ツールの存在を確認してから設定を適用
- **互換性**: Intel Macでも動作します

## トラブルシューティング

### コマンドが見つからない場合
```bash
# シェルを再起動
exec zsh

# PATHを確認
echo $PATH
```

### Homebrewのパスが正しくない場合
```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

### zplugが初回起動時にインストールされない場合
`.zshrc`を読み込み直すと、自動的にインストールプロンプトが表示されます：
```bash
source ~/.zshrc
```

## ライセンス

MIT

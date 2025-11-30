# --------------
# Java (OpenJDK 17)
# --------------
export JAVA_HOME=$(/usr/libexec/java_home -v "17")
export PATH=$PATH:${JAVA_HOME}/bin

# --------------
# Android Development
# --------------
# Android SDKディレクトリが存在する場合のみ設定を適用
if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

# --------------
# Flutter
# --------------
# Flutterディレクトリが存在する場合のみPATHに追加
if [[ -d "$HOME/flutter" ]]; then
    export PATH=$PATH:$HOME/flutter/bin
fi

# --------------
# Go (goenv)
# --------------
# goenvコマンドが存在する場合のみ初期化
if command -v goenv &> /dev/null; then
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$GOPATH/bin:$PATH"
fi

# --------------
# Python (pyenv)
# --------------
# pyenvコマンドが存在する場合のみ初期化
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# --------------
# Node.js (nvm)
# --------------
export NVM_DIR="$HOME/.nvm"
# nvmスクリプトが存在する場合のみ読み込み
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# --------------
# Ruby (rbenv)
# --------------
# rbenvコマンドが存在する場合のみ初期化
if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh)"
fi

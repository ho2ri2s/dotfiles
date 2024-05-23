export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME=`/usr/libexec/java_home -v "17"`
export PATH=$PATH:${JAVA_HOME}/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:/Users/ho2ri/FlutterProjects/flutter/bin"
export PATH=$PATH:/usr/local/go/bin
export PYENV_ROOT="$HOME/.pyenv/shims"
export PATH=$PATH:$HOME/flutter/bin
export PATH="$PYENV_ROOT:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/python"
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
export PATH=$PATH:$NVM_DIR
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"
eval "$(pyenv init --path)"


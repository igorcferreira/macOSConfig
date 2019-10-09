export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools:$PATH"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:/usr/local/freeswitch/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export XCODE_CONTENT="/Applications/Xcode.app/Contents"
export DEVELOPER_DIR="$XCODE_CONTENT/Developer"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias symbolicatecrash="$XCODE_CONTENT/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load simple profile
[[ -s "$HOME/.bash_functions" ]] && source "$HOME/.bash_functions" # Loads a set of functions that can be useful

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export GPG_TTY=$(tty)

#!/usr/bin/env bash

# --------
# Homebrew: Install, update, upgrade and cleanup 
# ------

# resolve links - $0 may be a softlink
PRG="$0"
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done
PRGDIR=`dirname "$PRG"`
source "$PRGDIR"/../scripts/include.sh

install_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then

        # XCode Command Line Tools is required for Homebrew
        # (since we are able to git clone this repo xcode should already have been installed)
        if ! xcode-select --print-path &> /dev/null; then
            fail "command-line tools for Xcode must be installed before we can use Homebrew. \n"
        fi 
        action "installing homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [[ $? != 0 ]]; then
            fail "unable to install homebrew, script $0"
        fi
        success "Homebrew is installed"
        action "Installing homebrew bundle.. (brew bundle)"
        brew bundle 
        success
    fi
}

update() {
    info "Updating Homebrew... (brew update)"
    brew update
    success
}
upgrade() {
    info "Upgrading formulae...(brew upgrade)"
    brew upgrade
    success
}
cleanup() {
    info "Cleaning up Homebrew... (brew cleanup)"
    brew cleanup
    success
}

main() {
    heading "Brewing with Homebrew"
    install_homebrew
    update
    upgrade
    cleanup
    success "Done brewing"
}

main
fish_add_path \
    $HOME/bin \
    $HOME/.local/bin \
    $HOME/Repos/EasyRSA-3.1.7

set fish_greeting
set -gx GPG_TTY (tty)
set -gx EDITOR hx
set -gx OAI_BASE_URL "https://openrouter.ai/api/v1"
set -gx OAI_API_KEY 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

function lightmode
    set -gx BAT_THEME OneHalfLight
    sed -i '' 's/theme = ".*"/theme = "onelight"/' ~/.config/helix/config.toml
    set -gx AIDER_LIGHT_MODE True
    pkill -USR1 hx
end

function darkmode
    set -gx BAT_THEME TwoDark
    sed -i '' 's/theme = ".*"/theme = "onedark"/' ~/.config/helix/config.toml
    set -gx AIDER_DARK_MODE True
    pkill -USR1 hx
end

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
    status --is-command-substitution; and return

    # Check if we are inside a git directory
    if git rev-parse --show-toplevel &>/dev/null
        set gitdir (realpath (git rev-parse --show-toplevel))
        set cwd (pwd -P)
        # While we are still inside the git directory, find the closest
        # virtualenv starting from the current directory.
        while string match "$gitdir*" "$cwd" &>/dev/null
            if test -e "$cwd/.venv/bin/activate.fish"
                source "$cwd/.venv/bin/activate.fish" &>/dev/null
                return
            else
                set cwd (path dirname "$cwd")
            end
        end
    end
    # If virtualenv activated but we are not in a git directory, deactivate.
    if test -n "$VIRTUAL_ENV"
        deactivate
    end
end

function fish_mode_prompt
end

switch (uname)
    case Darwin
        fish_add_path \
            /Applications/kitty.app/Contents/MacOS \
            /opt/homebrew/opt/node@18/bin \
            /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin \
            $HOME/.cargo/bin \
            eval (/opt/homebrew/bin/brew shellenv)
        /usr/bin/ssh-add --apple-use-keychain ~/.ssh/id &>/dev/null
        /usr/bin/ssh-add --apple-load-keychain &>/dev/null
        set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
        set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include
        set -gx CPLUS_INCLUDE_PATH "$(brew --prefix)/include"
        alias pinentry="pinentry-mac"
        source ~/.orbstack/shell/init2.fish 2>/dev/null || :
    case Linux
end


if status is-interactive
    starship init fish | source
    zoxide init fish | source
    __auto_source_venv

    alias ssh="kitty +kitten ssh"
    alias cat=bat
    alias c="clear"
    alias gdiff="git difftool --no-symlinks --dir-diff"

    alias g="git"
    alias gc="git commit -v"
    alias gch="git checkout"
    alias g+b="git checkout -b"
    alias gdca="git diff --cached"
    alias glo="git log --pretty=format:'%C(yellow)%h %Cred%G? %Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s' --date=relative --graph"
    alias gph="git push"
    alias ga="git add"
    alias gst="git status"
    alias grb="git rebase"
    alias gsh="git stash"
    alias gpl="git pull"
    alias gb="git branch"
    alias gsl="git sl"
    alias gsw="git sw"

    alias j=jj

    alias dc="docker compose"
end

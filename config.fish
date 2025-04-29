fish_add_path \
    /opt/homebrew/opt/llvm/bin \
    /opt/homebrew/opt/node@18/bin \
    $HOME/.cargo/bin \
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin \
    /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin \
    $HOME/Library/Python/3.11/bin \
    $HOME/Repos/EasyRSA-3.1.7 \
    /Applications/kitty.app/Contents/MacOS \
    $HOME/bin \
    /Library/Java/JavaVirtualMachines/graalvm-jdk-21.0.3+7.1/Contents/Home/bin \
    $HOME/.mint/bin \
    $HOME/.local/bin

set fish_greeting
eval (/opt/homebrew/bin/brew shellenv)
set -x GPG_TTY (tty)
set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include
set -gx CPLUS_INCLUDE_PATH "$(brew --prefix)/include"
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home
set -gx MACOSX_DEPLOYMENT_TARGET 14.4.1
set -gx OAI_BASE_URL "https://openrouter.ai/api/v1"
set -gx OAI_API_KEY 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
set -gx HELIX_RUNTIME /Users/thomas/repos/helix/runtime

function lightmode
    # kitty +kitten themes --reload-in=all "Atom One Light"
    set -gx BAT_THEME OneHalfLight
    sed -i '' 's/theme = ".*"/theme = "onelight"/' ~/.config/helix/config.toml
    set -gx AIDER_LIGHT_MODE True
    pkill -USR1 hx
end

function darkmode
    # kitty +kitten themes --reload-in=all "One Dark"
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

function mudir
    mkdir $argv[1] && cd $argv[1]
end

function fish_mode_prompt
end

# function __direnv --on-variable PWD --description "Source .env file on directory change"
#   status --is-command-substitution; and return

#   if git rev-parse --show-toplevel &>/dev/null
#     set gitdir (realpath (git rev-parse --show-toplevel))
#     if test -e "$gitdir/.env"
#       while read -l line
#         set line (string trim $line -l)
#         if not string match '#*' $line >/dev/null
#           set arr (string split '=' $line -m 1)
#           if test $status -eq 0
#             set -gx $arr[1] $arr[2]
#           end
#         end
#       end < "$gitdir/.env"
#     end
#   end
# end

/usr/bin/ssh-add --apple-use-keychain ~/.ssh/id &>/dev/null
/usr/bin/ssh-add --apple-load-keychain &>/dev/null

if status is-interactive
    set EDITOR vim

    starship init fish | source
    __auto_source_venv

    alias ssh="kitty +kitten ssh"
    alias pinentry="pinentry-mac"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /Users/thomas/miniconda3/bin/conda
#     eval /Users/thomas/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# end
# <<< conda initialize <<<
set -Ux EDITOR $HOME/.cargo/bin/hx

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

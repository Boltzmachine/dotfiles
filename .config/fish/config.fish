if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim nvim
alias vide neovide
alias dotfiles "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

# opam configuration
source /Users/qiuweikang/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

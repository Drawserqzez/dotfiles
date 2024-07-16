if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

# Nvm is cool
nvm use lts -s

# add rust directory to path
fish_add_path ~/.cargo/bin/

# fzf.fish keybinds
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs

function starship_transient_rprompt_func
    starship module time
end

if starship --version >> /dev/null
    starship init fish | source
    enable_transience
end


set -gx LANG "en_US.UTF-8"
set -gx LC_NUMERIC "sv_SE.UTF-8"
set -gx LC_TIME "sv_SE.UTF-8"
set -gx LC_MONETARY "sv_SE.UTF-8"
set -gx LC_PAPER "sv_SE.UTF-8"
set -gx LC_NAME "sv_SE.UTF-8"
set -gx LC_ADDRESS "sv_SE.UTF-8"
set -gx LC_TELEPHONE "sv_SE.UTF-8"
set -gx LC_MEASUREMENT "sv_SE.UTF-8"
set -gx LC_IDENTIFICATION "sv_SE.UTF-8"


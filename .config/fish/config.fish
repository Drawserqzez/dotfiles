if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

# Nvm is cool
if type -q nvm 
    nvm use lts -s
end

# add rust directory to path
fish_add_path ~/.cargo/bin/

# fzf.fish keybinds
if type -q fisher
    fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp
end

function starship_transient_rprompt_func
    starship module time
end

function starship_transient_prompt_func
    starship module character
end

if type -q starship
    starship init fish | source
    # enable_transience
end


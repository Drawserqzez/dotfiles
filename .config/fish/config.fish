if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Nvm is cool
nvm use lts -s

# add rust directory to path
fish_add_path ~/.cargo/bin/

# fzf.fish keybinds
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs

if starship --version >> /dev/null
    starship init fish | source
end


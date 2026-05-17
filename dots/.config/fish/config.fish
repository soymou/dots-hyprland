# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        enable_transience
    end
    
    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    neofetch

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
    if test "$TERM" = "xterm-kitty"
        alias ssh 'kitten ssh'
    end
end


function update
    pushd ~/NixOS

    switch $argv[1]
        # Case 1: 'update flake'
        case flake
            sudo nix flake update

        # Case 2: 'update nixos'
        case nixos
            sudo nixos-rebuild switch --flake .#mou

        # Case 3: 'update' (no arguments) -> Do both
        case ''
            sudo nix flake update
            # The 'and' ensures we only rebuild if the update succeeded
            and sudo nixos-rebuild switch --flake .#mou

        # Fallback for typos
        case '*'
            echo "Usage: update [flake|nixos]"
    end

    popd
end


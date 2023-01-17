############ Vim

function vimpup -d "Update vim plugins"
    vim +PluginInstall +qall
end

############ dnf -> Fedora's package manager

function s -d "Search dnf repository"
    dnf search $argv
end

function i-rpm -d "Install rpm"
    sudo dnf localinstall $argv
end

function upg -d "Upgrade all packages"
    sudo dnf -y upgrade
end

function rmp -d "Remove package from system"
    sudo dnf remove $argv
end

function i -d "Install package to system"
    sudo dnf install $argv
end

function si -d "Install package to system with snap"
    sudo snap install $argv
end

############ Config

function fishconf -d "Open fish config file"
    sudo vim ~/.config/fish/config.fish
end

function kittyconf -d "Open kitty config file"
    vim ~/.config/kitty/kitty.conf
end

############ Console

function yarn:berry -d "Set yarn version to berry with Typescript plus VSCode"
    yarn set version berry
    yarn plugin import typescript
    yarn dlx @yarnpkg/sdks vscode
    yarn
end

function br --wraps br -d "Open broot (tree) with nice options"
    command br -w -s -g $argv
end

function t -d "Concise bat"
    bat --tabs 2 $argv
end

function tt -d "Concise bat plain text (like cat)"
    bat --tabs 2 -p $argv
end

function curl --wraps curl -d "Use curlie in place of curl"
    curlie $argv
end

function l1 -d "Display files and directories on one line each"
    exa -Fl $argv
end

function fd --wraps fd -d "Find files fast"
    command fd --hidden --show-errors --list-details --full-path $argv
end

function fda --wraps fd -d "Find ALL files fast"
    command fd --unrestricted --show-errors --list-details --full-path $argv
end

function beep -d "Produce a beep sound on terminal"
    echo -n \a
end

function mkdir -d "Create a directory and set CWD"
    command mkdir $argv

    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'

            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end

function del -d "Delete a directory really fast (must have an empty directory '~/blank')"
    rsync -a --delete ~/blank/ $argv
    rmdir $argv
end

function l -d "Show everything under current directory"
    exa -a $argv
end

function lt -d "Show everything under 2 directories deep in tree format"
    exa -TbhL 2 $argv
end

function mkexec -d "Make file executable"
    chmod +x $argv
end

function ff -d "Fuzzy finder"
    fzf $argv
end

function fp -d "Fuzzy finder with preview (just for text filtering)"
    fzf --preview "bat --style=numbers --color=always --line-range :500 {}" $argv
end

function f -d "Fuzzy finder with ripgrep"
    ~/fuzzy_ripgrep $argv
end

function font -d "Reinicialize fonts cache on system"
    fc-cache -f -v
end

function dow -d "Go to ~/Downloads"
    cd ~/Downloads
end

function doc -d "Go to ~/Documents"
    cd ~/Documents
end

function bgt -d "Run command on background terminal"
    tmux new -d '$argv'
end

function untar -d "Untar a tar file"
    tar -xjvf $argv
end

function gr -d "Pretty and usefull grep-like command that searches everything"
    command rg --stats --no-ignore-global --line-number --no-ignore --pretty --no-ignore-dot --ignore-case --hidden --heading --follow --with-filename --context 3 $argv
end

function rgs -d "Another pretty and usefull grep-like command that respects global ignore"
    rg --stats --line-number --pretty --ignore-case --follow --context 3 $argv
end

function clip2file -d "Get text from clipboard and put it in a file (takes an argument that is the output file)"
    xclip -selection clipboard -o >$argv
end

function file2clip -d "Put file on clipboard (takes an argument that is the input file)"
    xclip -selection clipboard <$argv
end

function c- -d "Go to directory that you were last"
    cd -
end

function notify -d "This will beep when the most recent job completes"
    set -l job (jobs -l -g)
    or begin
        echo "There are no jobs" >&2
        return 1
    end

    function _notify_job_$job --on-job-exit $job --inherit-variable job
        echo -n \a # beep
        functions -e _notify_job_$job
    end
end

############ Git

function gs -d "Concise (git status)"
    git status -sb
end

function ga -d "Concise (git add .)"
    git add .
end

function gm -d "Concise (git commit -m) (takes an argument that is the commit message)"
    git commit -m $argv
end

function clone -d "Concise (git clone)"
    git clone $argv --depth 1
end

function gp -d "Concise (git push)"
    git push
end

function gl -d "Concise (git log)"
    git log
end

function gd -d "Concise (git diff)"
    git diff
end

function gam -d "Concise (git add . && git -m <msg>) (takes an argument that is the commit message)"
    ga
    gm $argv
end

function clone-branch -d "Concise (git clone --single-branch --branch <branch> --depth 1)"
    git clone --single-branch --depth 1 --branch $argv
end

function gamp -d "Concise (git add . && git -m <msg> && git push) (takes an argument that is the commit message)"
    ga
    gm $argv
    gp
end

function cherry -d "Do a cherry-pick git commit and change author to repository gitconfig author"
    git cherry-pick $argv
    GMESSAGE (git log -1 --pretty=%B)
    git reset HEAD~1
    git add .
    git commit -n -m $GMESSAGE
end

############

function cp
    xcp $argv
end

function tree
    broot $argv
end

function my
    cd ~/Documents/VSCode/my_projects
end

function lite
    ~/Apps/lite-xl/lite-xl (pwd) $argv &
end

############ Exports

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='command fd --type f'

# Setting a theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1'

############ Sources

# Bun.js
set -Ux BUN_INSTALL "/home/gabriel/.bun"
set -px --path PATH "/home/gabriel/.bun/bin"

# source ~/.asdf/asdf.fish

############ Fish config

set -g -x fish_greeting ''

############ Starship

starship init fish | source

export PATH="$PATH:/home/gabriel/.bin"

############ OpenAI

# Copilot for terminal:
export OPENAI_API_KEY="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"

function copilot -d "OpenAI copilot for your terminal"
    plz $argv
end

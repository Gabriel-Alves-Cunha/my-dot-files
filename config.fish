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

function t -d "Concise bat"
    bat --tabs 2 $argv
end

function tt -d "Concise bat plain text (like cat)"
    bat --tabs 2 -p $argv
end

function ll -d "Display files and directories on one line each"
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

function cl -d "Clear console"
    clear
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

############ Sources

# Bun.js
set -Ux BUN_INSTALL "/home/gabriel/.bun"
set -px --path PATH "/home/gabriel/.bun/bin"

source ~/.asdf/asdf.fish

############ Fish config

set -g -x fish_greeting ''

############ Vim

function vimpup -d "Update vim plugins"
    vim +PluginInstall +qall
end

############

function s -d "Search for pkg"
    brew search $argv
end

function upg -d "Upgrade all packages"
    brew update
    brew upgrade
end

function rmp -d "Remove package from system"
    brew uninstall $argv
end

function i -d "Install package to system"
    brew install $argv
end

############ Config

function fishconf -d "Open fish config file"
    $EDITOR ~/.config/fish/config.fish
end

function kittyconf -d "Open kitty config file"
    $EDITOR ~/.config/kitty/kitty.conf
end

############ Console

function br --wraps br -d "Open broot (tree) with nice options"
    command br -w -s -g $argv
end

function loop -d "loop <count> <command(s)>" -a count
    for i in (seq 1 $count)
        eval $argv[2..-1]
    end
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

function del -d "Delete a directory really fast (must have an empty directory '~/.blank')" -a directory
    rsync -a --delete ~/.blank/ $directory
    rmdir $directory
end

function clear-dir -d "Delete everything inside a directory really fast (must have an empty directory '~/.blank')" -a directory
    rsync -a --delete ~/.blank/ $directory
end

function l -d "Show everything under current directory" -a directory
    eza -a $directory
end

function lt -d "Show everything under 2 directories deep in tree format" -a directory
    eza -TbhL 2 $directory
end

function mkexec -d "Make file executable" -a filename
    chmod +x $filename
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

function clip2file -d "Get text from clipboard and put it in a file (takes an argument that is the output file)" -a filename
    pbpaste >$filename
end

function file2clip -d "Put file on clipboard (takes an argument that is the input file)" -a filename
    pbcopy <$filename
end

function cl -d "Go to directory that you were last"
    cd -
end

function yt -d "Download mp3 audio from youtube video" -a youtube_link
    yt-dlp -t mp3 "$youtube_link" --no-playlist
end

function reload-fish-fns
    source ~/.config/fish/config.fish
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

function reload-libs
    sudo /sbin/ldconfig -v
end

############ Git

function gpp -d "git pull"
    git pull $argv
end

function gbd -d "Git diff two branches" -a branch
    git diff $branch..(git branch --show-current)
end

function gs -d "Concise (git status)"
    git status -sb
end

function git-file-history -a filename
    git log -p -- $filename
end

function ga -d "Stage all files"
    git add .
end

function g -d "Concise git"
    git $argv
end

function gt -d "Concise git stash"
    git stash $argv
end

function show-stash -a stash_number
    git stash show -p -w $stash_number
end

function gtl -d "Concise (git stash list)"
    git stash list $argv
end

function gtp -d "Concise (git stash pop)" -a index
    set -q index[1]
    or set index 0

    git stash pop stash@\{$index\}
end

function gc -d "Concise (git checkout)"
    git checkout $argv
end

function gcb -d "Concise (git checkout -b)"
    git checkout -b $argv
end

function delete-commit-from-branch
    git rebase -i HEAD~5
end

function gm -d "Concise (git commit -m) (takes an argument that is the commit message)" -a commit_message
    git commit -m $commit_message
end

function clone -d "Concise (git clone)" -a link
    git clone $link --depth 1 $argv[2..-1]
end

function gp -d "Concise (git push)"
    git push
end

function gl -d "Concise (git log)"
    git log $argv
end

function gd -d "Concise (git diff)"
    git diff --word-diff -w $argv
end

function gam -d "Concise (git add . && git -m <msg>) (takes an argument that is the commit message)" -a commit_message
    git add .
    git commit -m $commit_message
end

function clone-branch -d "Concise (git clone --single-branch --branch <branch> --depth 1)" -a link
    git clone --single-branch --depth 1 --branch $link
end

function gamp -d "Concise (git add . && git -m <msg> && git push) (takes an argument that is the commit message)" -a commit_message
    git add .
    git commit -m $commit_message
    git push
end

function cherry -d "Do a cherry-pick git commit and change author to repository gitconfig's author" -a hash
    git cherry-pick $hash

    set -l commit_message (git log -1 --pretty=%B)

    git reset HEAD~1
    git add .
    git commit -n -m "$commit_message"
end

function recent-branches -d "Show the last branches worked on" -a number_of_branches
    set -q number_of_branches[1]
    or set number_of_branches 20

    git for-each-ref --count $number_of_branches --sort=-committerdate refs/heads --format="%(refname:short)"
end

function lg
    lazygit $argv
end

function update-and-rebase -d "The argument is your main branch" -a main_branch options
    set -f my_branch (git branch --show-current)

    git checkout $main_branch
    git pull --rebase origin $main_branch
    git checkout $my_branch
    git rebase $main_branch $options
end

function update-and-merge -d "The argument is the branch you want to merge with" -a branch_to_merge_with
    set -f curr_branch (git branch --show-current)

    git checkout $branch_to_merge_with
    git pull origin $branch_to_merge_with
    git checkout $curr_branch
    git pull origin $curr_branch
    git merge --no-ff $branch_to_merge_with
end

function git-discard-all-unstaged-changes
    git restore .
end

function git-discard-all-staged-changes
    git reset HEAD
    git checkout .
end

function reset-ahead-behind
    set -f curr_branch (git branch --show-current)
    echo origin/$curr_branch
    git reset --hard origin/$curr_branch
end

function select-file-from-stash -a stash_number filename
    git checkout stash@\{$stash_number\} -- $filename
end

function update-child-branch -d "1º arg is the mother branch, 2º arg is the child branch" -a mother_branch child_branch
    git checkout $mother_branch
    git pull
    git checkout $child_branch
    git rebase $mother_branch $arvg[3]
end

function gpl -d "Git pull"
    git pull
end

############

function cp
    pbcopy $argv
end

function tree
    broot $argv
end

function my
    cd ~/Documents/VSCode/Personal
end

function lite
    ~/Apps/lite-xl/lite-xl (pwd) $argv &
end

function work
    cd ~/Documents/VSCode/Work
end

function dura-branch
    echo "dura/$(git rev-parse HEAD)"
end

function compress-video -a input_video output_video
    if test (count $argv) -lt 2
        echo "Usage: compress_video <input_video> <output_video> [crf] [preset]"
        return 1
    end

    set crf 23 # Default CRF
    set preset medium # Default preset

    if test (count $argv) -ge 3
        set crf $argv[3]
    end

    if test (count $argv) -ge 4
        set preset $argv[4]
    end

    ffmpeg -i "$input_video" -vcodec libx264 -crf $crf -preset $preset -acodec aac -b:a 128k "$output_video"

    echo "Compression complete: $output_video"
end

############ Exports

set -gx EDITOR code

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='command fd --type f --exclude ".git"'

# Setting a theme for fzf
export FZF_DEFAULT_OPTS='--color=bg+:#293739,bg:#1B1D1E,border:#808080,spinner:#E6DB74,hl:#7E8E91,fg:#F8F8F2,header:#7E8E91,info:#A6E22E,pointer:#A6E22E,marker:#F92672,fg+:#F8F8F2,prompt:#F92672,hl+:#F92672'

export FZF_CTRL_T_OPTS=''

############ Sources

# Java

set -gx JAVA_HOME $(/usr/libexec/java_home)

# Bun

set --export BUN_INSTALL $HOME/.bun
set --export PATH $BUN_INSTALL/bin $PATH

# Android Studio

set -gx ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

############ Fish config

set -g -x fish_greeting ''

############ Init

# Starship
starship init fish | source

# Atuin
atuin init fish | source

# Pyenv
# pyenv init - | source

# fnm
fnm env --use-on-cd | source

# Change limit of open files at a time:
ulimit -S -n 81920

# pnpm
set -gx PNPM_HOME /Users/sevenofnine/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# rbenv initialization for Fish shell
set -gx PATH (rbenv root)/shims $PATH
status --is-interactive; and . (rbenv init -|psub)

# Mole shell completion
set -l output (mole completion fish 2>/dev/null); and echo "$output" | source

# Add node to path for gsd:
fish_add_path "/Users/sevenofnine/Library/Application Support/fnm/node-versions/v24.14.0/installation/bin"

# Added by Antigravity IDE
fish_add_path /Users/sevenofnine/.antigravity-ide/antigravity-ide/bin

# Added by Antigravity IDE
fish_add_path /Users/sevenofnine/.antigravity-ide/antigravity-ide/bin

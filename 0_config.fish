function vimpup -d "Update vim plugins"
	vim +PluginInstall +qall
end

function t -d "Concise bat"
	bat --tabs 2 $argv
end

function tt -d "Concise bat plain text (like cat)"
	bat --tabs 2 -p $argv
end

function s -d "Search dnf repository"
	dnf search $argv
end

function fd --wraps fd -d "Find files fast"
	command fd --hidden --full-path $argv
end

function beep -d "Produce a beep sound on terminal"
	echo -n \a
end

function fishconf -d "Open fish config file"
	sudo vim ~/.config/fish/config.fish
end

function irpm -d "Install rpm"
	sudo dnf localinstall $argv
end

function kittyconf -d "Open kitty config file"
	vim ~/.config/kitty/kitty.conf
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
	exa -a
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
	git clone $argv
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

function gamp -d "Concise (git add . && git -m <msg> && git push) (takes an argument that is the commit message)"
	ga
	gm $argv
	gp
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

function volup -d "Set volume up by 10%"
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) +10%
end

function voldown -d "Set volume down by 10%"
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) -10%
end

function yarn:berry -d "Set yarn version to berry with Typescript plus VSCode"
	yarn set version berry
	yarn plugin import typescript
	yarn dlx @yarnpkg/sdks vscode
	yarn
end

function clip2file -d "Get text from clipboard and put it in a file (takes an argument that is the output file)"
	xclip -selection clipboard -o > $argv
end

function file2clip -d "Put file on clipboard (takes an argument that is the input file)"
	xclip -selection clipboard < $argv
end

function c- -d "Go to directory that you were last"
	cd -
end

function cl -d "Clear console"
	clear
end

##################### sources

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

source ~/.asdf/asdf.fish

##################### fish conf

set -g -x fish_greeting ''

# Bun
set -Ux BUN_INSTALL "/home/gabriel/.bun"
set -px --path PATH "/home/gabriel/.bun/bin"


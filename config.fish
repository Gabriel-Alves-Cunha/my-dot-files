function vimpup -d 'Update vim plugins'
	vim +PluginInstall +qall
end

function search
	dnf search $argv
end

function fishconf
	sudo vim ~/.config/fish/config.fish
end

function kittyconf
	vim ~/.config/kitty/kitty.conf
end

function upg
	sudo dnf -y upgrade
end

function find
	fd $argv
end

function rmp
	sudo dnf remove $argv
end

function i
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

function ls
	exa -a
end

function cx -d 'Make file executable'
	chmod +x $argv
end

function dow -d 'Go to Downloads'
    cd ~/Downloads
end

function doc -d 'Go to Documents'
    cd ~/Documents
end

function gs -d 'Concise (git status)'
    git status -sb
end

function ga -d 'Concise (git add .)'
	git add .
end

function gm -d 'Concise (git commit -m)'
	git commit -m $argv
end

function clone -d 'Concise (git clone)'
	git clone $argv
end

function f -d 'fzfx'
	fzfx
end

function volup
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) +10%
end

function voldown
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) -10%
end

# sources
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

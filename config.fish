function fishconf
	sudo vi ~/.config/fish/config.fish
end

function kittyconf
	sudo vi ~/.config/kitty/kitty.conf
end

function upg
	sudo dnf upgrade
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

function down -d 'Go to Downloads'
    cd ~/Downloads
end

function doc -d 'Go to Documents'
    cd ~/Documents
end

function gs -d 'Concise (git status)'
    git status -sb
end

function volup
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) +10%
end

function voldown
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) -10%
end

# sources
if test -f /home/gabriel/.autojump/share/autojump/autojump.fish; . /home/gabriel/.autojump/share/autojump/autojump.fish; end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

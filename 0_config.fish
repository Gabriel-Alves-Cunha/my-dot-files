function vimpup -d 'Update vim plugins'
	vim +PluginInstall +qall
end

function search
	dnf search $argv
end

function fd --wraps fd -d "Find files fast"
	command fd --hidden --full-path $argv
end

function beep
	echo -n \a
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

function del
	rsync -a --delete ~/blank/ $argv
	rm -rf $argv
end
	
function l
	exa -a
end

function mkexec -d 'Make file executable'
	chmod +x $argv
end

function font -d "Reinicialize fonts cache on system"
	fc-cache -f -v
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

function gp -d 'Concise git push'
        git push
end

function untar
        tar -xjvf $argv
end

function rg
        command rg --stats --no-ignore-global --line-number --no-ignore --pretty --no-ignore-dot --ignore-case --hidden --heading --auto-hybrid-regex --follow --with-filename $argv
end

function volup
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) +10%
end

function voldown
	pactl -- set-sink-volume (pactl list | grep -B 1 'RUNNING' | grep -o '[0-9]' | read -z) -10%
end

function lisp -d "Run a CommomLisp file. You can just use the base of the file name, and if there's a compiled version, then SBCL should load that, and if there's not, then SBCL will load the source file and compile it."
	sbcl --noinform --load $argv --eval '(sb-ext:quit)'
end

function yarn:berry -d "Set yarn version to berry with typescript + vscode."
	yarn set version berry
	yarn plugin import typescript
	yarn dlx @yarnpkg/sdks vscode
	yarn
end

##################### sources

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

source ~/.asdf/asdf.fish

##################### fish conf

set -g -x fish_greeting ''

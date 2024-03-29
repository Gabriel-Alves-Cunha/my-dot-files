# supress init msg
set -U fish_greeting ""

# for fedora (with fish.conf available)
i kitty openssl

# vim and tauri(usefull stuff)
i python3-devel cmake
upg
sudo dnf check-update && sudo dnf install webkit2gtk3-devel.x86_64 \
    openssl-devel \
    curl \
    wget \
    squashfs-tools \
    && sudo dnf group install "C Development Tools and Libraries"

echo "Installing protonvpn-cli"
echo "[proton-fedora-33-unstable]
name="fedora-33-unstable"
baseurl=https://repo.protonvpn.com/fedora-33-unstable/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://repo.protonvpn.com/fedora-33-unstable/public_key.asc" | sudo vim /etc/yum.repos.d/fedora-33-unstable.repo
upg
echo "Now, login in protonvpn!!"

# install rust stuff
echo "Installing Volta and NodeJS"
sudo curl https://get.volta.sh | bash
volta completions
volta install node

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path $HOME/.cargo/bin/

echo "Installing linux rust utils"
i -y ripgrep bat exa fd-find
cargo install --locked ripgrep-all

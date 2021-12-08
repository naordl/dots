# Dotfiles

## Usage

### Prerequisites
- Have a base install of Arch Linux ready, along with a user that has `sudo` privileges.
- Make all the relevant shell scripts executable using the following command: `chmod +x install.sh deploy.sh configure.sh`
- You must place this repository in $HOME/.local/src/, otherwise the scripts will complain.
    * This is done to keep $HOME clean.

### Instructions
1. Install the packages using the `install.sh` script.
2. Deploy the dotfiles with the `deploy.sh` script.
3. Configure the default shells, crontab, systemd services, and grub with the `configure.sh` script.
4. Reboot for most changes to take effect.

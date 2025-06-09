
# Makefile for the management of configuration files.

GITHUB_ANDREY = https://github.com/aepifanov
HOME_REPO = $(GITHUB_ANDREY)/.home.git
VIM_REPO = $(GITHUB_ANDREY)/.vim.git


INSTALL = apt-get --yes --force-yes install

.PHONY: help
help:
	@egrep "^# target:" [Mm]akefile | sort


#
# Base
#
HOME_CONFIGS = $(HOME)/.gitconfig \
	       $(HOME)/.screenrc
.PHONY: install_base
# target: install_base   - Install HOME configuration files
install_base: $(HOME_CONFIGS)

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/gitconfig $@

$(HOME)/.screenrc:
	ln -s $(CURDIR)/screenrc $@

.PHONY: clean_base
# target: clean_base     - Clean HOME configuration files.
clean_base:
	@echo
	@echo " Clean HOME configuration files."
	@echo
	sudo rm -rf $(HOME_CONFIGS)

#
# SSH
#
.PHONY: install_ssh
# target: install_ssh    - Install SSH  config and autorized files.
SSH_CONFIGS = $(HOME)/.ssh \
	$(HOME)/.ssh/authorized_keys \
	$(HOME)/.ssh/config.main
install_ssh: $(SSH_CONFIGS)

$(HOME)/.ssh:
	mkdir -p $@

$(HOME)/.ssh/authorized_keys: $(HOME)/.ssh
	cat $(CURDIR)/ssh/id_rsa.pub >> $@

$(HOME)/.ssh/config.main: $(HOME)/.ssh
	ln -s $(CURDIR)/ssh/config.main $@

.PHONY: clean_ssh
# target: clean_ssh      - Clean SSH  config and autorized files.
clean_ssh:
	@echo
	@echo " Clean SSH configuration files."
	@echo
	rm $(HOME)/.ssh/config.main

#
# VIM
#
.PHONY: install_vim
# target: install_vim    - Install VIM  files.
VIM_TARGETS = $(HOME)/.vimrc \
	$(HOME)/.vim
install_vim: clean_vim \
	$(VIM_TARGETS)
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	tar xzf nvim-linux-x86_64.tar.gz  --strip-components=1 -C ~/local
	git clone https://github.com/aepifanov/nvim ~/.config/nvim

$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	@echo
	git clone --recursive $(VIM_REPO) $@

$(HOME)/.vimrc: $(HOME)/.vim
	cd $< && make install


.PHONY: clean_vim
# target: clean_vim      - Clean VIM  files.
clean_vim:
	@echo
	@echo " Clean VIM files."
	@echo
	rm -rf $(VIM_TARGETS)


#
# ZSH
#
.PHONY: install_zsh
# target: install_zsh    - Install ZSH and configure it.
install_zsh:
	@echo
	@echo " Install ZSH."
	@echo
	sudo $(INSTALL) zsh
	CHSH=yes RUNZSH=no bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
	rm ~/.zshrc
	ln -s $(CURDIR)/zsh/zshrc ~/.zshrc

.PHONY: clean_zsh
# target: clean_zsh      - Clean ZSH.
clean_zsh:
	@echo
	@echo " Clean VIM files."
	@echo
	rm -rf ~/.oh-my-zsh
	rm ~/.zshrc


#
# Ubuntu
#
.PHONY: install_ubuntu
# target: install_ubuntu - Install All  needed packages.
install_ubuntu: /etc/sudoers.d/$(USER)
	@echo
	@echo " Install All needed packages."
	@echo
	sudo apt-get --yes --force-yes install \
		zsh mc jq tree dos2unix \
		build-essential module-assistant dkms \
		automake autoconf exuberant-ctags cscope gdb



# Rule to install sudoers file
/etc/sudoers.d/$(USER):
	@if [ "$$(uname)" = "Linux" ]; then \
		echo "$(USER) ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$(USER); \
		sudo chmod 0440 /etc/sudoers.d/$(USER); \
	else \
		echo "Skipping sudoers setup: not Linux."; \
	fi

.PHONY: clean_ubuntu
# target: clean_ubuntu   - Clean Ubunutu needed packages.
clean_ubuntu:
	sudo rm /etc/sudoers.d/$(USER)

#
# ALL
#
.PHONY: install_all
# target: install_all    - Install ALL files.
install_all: install_base install_vim

.PHONY: clean_all
# target: clean_all      - Clean ALL files.
clean_all: clean_base clean_vim


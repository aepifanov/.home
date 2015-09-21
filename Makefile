
# Makefile for the management of configuration files.

GITHUB_ANDREY = https://github.com/aepifanov
	HOME_REPO = $(GITHUB_ANDREY)/.home.git
	VIM_REPO = $(GITHUB_ANDREY)/.vim.git

.PHONY: help
help:
	@egrep "^# target:" [Mm]akefile | sort

#
#
#

.PHONY: install
# target: install     - Install HOME configuration files
HOME_CONFIGS = $(HOME)/.gitconfig \
			   $(HOME)/.zshrc     \
			   $(HOME)/.screenrc
install: $(HOME_CONFIGS) \
		 install_ssh

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/gitconfig $@

$(HOME)/.zshrc:
	ln -s $(CURDIR)/zshrc $@

$(HOME)/.screenrc:
	ln -s $(CURDIR)/screenrc $@

.PHONY: clean
# target: clean       - Clean HOME configuration files.
clean: clean_ssh
	@echo
	@echo " Clean HOME configuration files."
	@echo
	rm -rf $(HOME_CONFIGS)

#
# SSH
#

.PHONY: install_ssh
# target: install_ssh - Install SSH  config and autorized files.
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
# target: clean_ssh   - Clean SSH  config and autorized files.
clean_ssh:
	@echo
	@echo " Clean SSH configuration files."
	@echo
	rm -rf $(SSH_CONFIGS)

#
# VIM
#

.PHONY: install_vim
# target: install_vim - Install VIM  files.
VIM_TARGETS = $(HOME)/.vimrc \
			  $(HOME)/.vim
install_vim: $(VIM_TARGETS)

$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	@echo
	git clone --recursive $(VIM_REPO) $@

$(HOME)/.vimrc: $(HOME)/.vim
	cd $< && make install


.PHONY: clean_vim
# target: clean_vim   - Clean VIM  files.
clean_vim:
	@echo
	@echo " Clean VIM files."
	@echo
	rm -rf $(VIM_TARGETS)

#
# ALL
#

.PHONY: install_all
# target: install_all - Install ALL  files.
install_all: install install_vim

.PHONY: clean_all
# target: clean_all   - Clean ALL  files.
clean_all: clean clean_vim

#
# ENV
#

.PHONY: install_env
# target: install_env - Install All  needed packages.
install_env:
	@echo
	@echo " Install All needed packages."
	@echo
	sudo apt-get --yes --force-yes install \
	                     zsh mc dos2unix \
	                     mercurial meld \
	                     build-essential module-assistant dkms \
	                     automake autoconf exuberant-ctags cscope gdb valgrind \
	                     libevent-dev libxml2-dev libxslt1-dev \
	                     python-pip python-dev python-ipdb python-virtualenv python-setuptools ipython-notebook jq

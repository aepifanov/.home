
# Makefile for the management of configuration files.

GITHUB_ANDREY = https://github.com/aepifanov
	HOME_REPO = $(GITHUB_ANDREY)/.home.git
	VIM_REPO = $(GITHUB_ANDREY)/.vim.git


.PHONY: help
help:
	@egrep "^# target:" [Mm]akefile


.PHONY: all_install
# target: all_install - Install ALL files.
all_install: install vim_install

.PHONY: all_update
# target: all_update  - Update  ALL files.
all_update: update vim_update

.PHONY: all_clean
# target: all_clean   - Clean   ALL files.
all_clean: clean vim_clean ssh_clean

.PHONY: install
# target: install     - Install HOME configuration files
HOME_CONFIGS = $(HOME)/.gitconfig \
			   $(HOME)/.zshrc     \
			   $(HOME)/.screenrc
install: ssh_install \
	     $(HOME_CONFIGS)

.PHONY: update
# target: update      - Update  HOME configuration files.
update:
	@echo
	@echo " Update HOME configuration files."
	@echo
	git pull


.PHONY: clean
# target: clean       - Clean   HOME configuration files.
clean:
	@echo
	@echo " Clean HOME configuration files."
	@echo
	rm -rf $(HOME_CONFIGS)

.PHONY: ssh_install
# target: ssh_install - Install SSH config and autorized files.
SSH_CONFIGS = $(HOME)/.ssh/authorized_keys \
			  $(HOME)/.ssh/config.main
ssh_install: $(HOME)/.ssh \
	         $(SSH_CONFIGS)

.PHONY: ssh_clean
# target: ssh_clean   - Clean   SSH config and autorized files.
ssh_clean:
	@echo
	@echo " Clean SSH configuration files."
	@echo
	rm -rf $(SSH_CONFIGS)

$(HOME)/.ssh:
	mkdir -p $@

$(HOME)/.ssh/authorized_keys:
	ln -s $(CURDIR)/ssh/authorized_keys $@

$(HOME)/.ssh/config.main:
	ln -s $(CURDIR)/ssh/config.main $@

$(HOME)/.gitconfig:
	ln -s $(CURDIR)/gitconfig $@

$(HOME)/.zshrc:
	ln -s $(CURDIR)/zshrc $@

$(HOME)/.screenrc:
	ln -s $(CURDIR)/screenrc $@

VIM_TARGETS = $(HOME)/.vimrc $(HOME)/.vim


# target: vim_install - Install VIM files.
.PHONY: vim_intall
vim_install: $(VIM_TARGETS)


.PHONY: vim_clean
# target: vim_clean   - Clean   VIM files.
vim_clean:
	@echo
	@echo " Clean VIM files."
	@echo
	rm -rf $(VIM_TARGETS)


$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	@echo
	git clone --recursive $(VIM_REPO) $@


$(HOME)/.vimrc: $(HOME)/.vim
	cd $< && make install


.PHONY: vim_update
# target: vim_update  - Update  VIM files.
vim_update:
	@echo
	@echo " Update VIM files."
	@echo
	cd $(HOME)/.vim && make update


.PHONY: env_install
# target: env_install - Install All needed packages.
env_install:
	@echo
	@echo " Install All needed packages."
	@echo
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get install zsh mc dos2unix \
	                     git mercurial meld \
	                     build-essential modu le-assistant dkms \
	                     automake autoconf ctags cscope gdb valgrind \
	                     libevent-dev libxml2-dev libxslt1-dev \
	                     python-pip python-dev python-virtualenv python-setuptools ipython-notebook



# Makefile for the management of configuration files.

GITHUB_ANDREY = git://github.com/aepifanov
HOME_REPO = $(GITHUB_ANDREY)/.home.git
VIM_REPO = $(GITHUB_ANDREY)/.vim.git


.PHONY: help
help:
	@egrep "^# target:" [Mm]akefile


.PHONY: install_all
# target: install_all - Install HOME and VIM files.
update: update vim_update 

.PHONY: update_all
# target: update_all  - Update  HOME and VIM files.
update: update vim_update 

.PHONY: install
# target: install     - Install HOME configuration files
install: ssh_install $(HOME)/.gitconfig $(HOME)/.zshrc $(HOME)/.screenrc

.PHONY: update
# target: update      - Update  HOME configuration files.
home_update:
	@echo 
	@echo " Update HOME configuration files."
	@echo 
	git pull 

.PHONY: ssh_install
# target: ssh_install - Install SSH config and autorized files.
ssh_install: $(HOME)/.ssh $(HOME)/.ssh/authorized_keys $(HOME)/.ssh/config

$(HOME)/.ssh:
	mkdir -p $(HOME)/.ssh

$(HOME)/.ssh/authorized_keys:
	ln -s $(CURDIR)/ssh/authorized_keys $@

$(HOME)/.ssh/config:
	ln -s $(CURDIR)/ssh/config $@

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
	rm -rf .vim*


$(HOME)/.vim:
	@echo
	@echo " Install VIM files."
	@echo
	git clone --recursive $(VIM_REPO) $(HOME)/.vim


$(HOME)/.vimrc: $(HOME)/.vim
	cd $(HOME)/.vim && make install


.PHONY: vim_update
# target: vim_update  - Update  VIM files.
vim_update:
	@echo 
	@echo " Update VIM files."
	@echo 
	cd $(HOME)/.vim && make update


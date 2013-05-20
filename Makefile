
# Makefile for the management of configuration files.

GITHUB_REPO = git://github.com/aepifanov


.PHONY: help
help:
	@egrep "^# target:" [Mm]akefile


.PHONY: push
# target: push        - Push    HOME configuration files update to repo.
push:  
	git push git@github.com:aepifanov/config.git master	


.PHONY: update
# target: update      - Update  HOME and VIM.
update: vim_update home_update


.PHONY: home_update
# target: home_update - Update  HOME configuration files.
home_update:
	@echo 
	@echo " Update HOME configuration files."
	@echo 
	cd $(HOME) && git pull $(GITHUB_REPO)/config.git master 


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
	git clone --recursive $(GITHUB_REPO)/.vim.git


$(HOME)/.vimrc: $(HOME)/.vim
	cd $(HOME)/.vim && make install


.PHONY: vim_update
# target: vim_update  - Update  VIM files.
vim_update:
	cd $(HOME)/.vim && make update


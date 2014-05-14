all: link

pull:
	@ruby ./install.rb --pull
link:
	[ ! -d $(HOME)/Library/bin ] || mkdir -p $(HOME)/Library/bin
	@ruby ./git-hook.rb
	@ruby ./install.rb --no-pull

clean: distclean

distclean:
	@ruby ./install.rb --uninstall

all: link

pull:
	@ruby ./install.rb --pull
link:
	@ruby ./git-hook.rb
	@ruby ./install.rb --no-pull

clean: distclean

distclean:
	@ruby ./install.rb --uninstall

build:
	@rm -rf html
	@make prod
	@make test

prod: 

	@echo "Updating repos"
	cd lib/repos/tinygrowl;git pull;
	cd lib/repos/bootstrap;git pull;

	@echo "Making our dist and tests folders if they don't already exist"
	@mkdir -p dist tests
	@echo "Clearing out previous folder..."
	@rm -rf dist/*
	@echo "Copying kickstrap folder..."
	@mkdir dist/kickstrap
	@cp -r lib/kickstrap/* dist/kickstrap/
	@echo "Delete contents of apps folder and individually select apps..."
	@rm -rf dist/kickstrap/apps/*
		@echo "-Animate.CSS"
		@cp -r lib/kickstrap/apps/animatecss dist/kickstrap/apps/
		
		@echo "-Bootstrap app references"
		@cp -r lib/kickstrap/apps/bootstrap dist/kickstrap/apps/

			@echo "Bootstrap files"
			@cp -r lib/repos/bootstrap dist/kickstrap/_core/
	
		@echo "-Ember.js"
		@cp -r lib/kickstrap/apps/ember dist/kickstrap/apps/

		@echo "-Ping"
		@cp -r lib/kickstrap/apps/ping dist/kickstrap/apps/
	
		@echo "-Knockout.js"
		@cp -r lib/kickstrap/apps/knockout dist/kickstrap/apps/
	
		@echo "-Chosen"
		@cp -r lib/kickstrap/apps/chosen dist/kickstrap/apps/
	
		@echo "-Color Schemer"
		@cp -r lib/kickstrap/apps/colorschemer dist/kickstrap/apps/
	
		@echo "-TinyGrowl"
		@cp -r lib/repos/tinygrowl dist/kickstrap/apps/
		
		@echo "-jQuery Lint"
		@cp -r lib/kickstrap/apps/jquerylint dist/kickstrap/apps/
	
		@echo "-Updater"
		@cp -r lib/kickstrap/apps/updater dist/kickstrap/apps/
		
		@echo "-Firebug Lite"
		@cp -r lib/kickstrap/apps/firebuglite dist/kickstrap/apps/
	
		@echo "-Universal"
		@cp -r lib/kickstrap/apps/universal dist/kickstrap/apps/
	
	@echo "Removing some themes not ready for prime time..."
	@find . -name .DS_Store -exec rm -f {} \;
	@rm -r dist/kickstrap/themes/smallworld/*
	@rmdir dist/kickstrap/themes/smallworld
	@rm -r dist/kickstrap/themes/smallworld.less
	@rm -rf dist/kickstrap/themes/confetti/*
	@rmdir dist/kickstrap/themes/confetti
	@rm -r dist/kickstrap/themes/confetti.less
	@echo "Removing .git directory from Bootstrap"
	@rm -rf dist/kickstrap/bootstrap/.git dist/kickstrap/bootstrap/.[a-z]*
	@rm -rf tests/kickstrap/bootstrap/.git tests/kickstrap/bootstrap/.[a-z]*
	@echo "Spring cleaning"
	@rm -r dist/kickstrap/apps/universal/ks-window
	@node build.js distion
	@echo "Moving in default index file"
	@cp dist/kickstrap/_examples/index.html dist/

	@uglifyjs dist/kickstrap/_core/js/less-1.4.0.js -mc > dist/kickstrap/_core/js/less-1.4.0.min.js
	@uglifyjs dist/kickstrap/_core/js/kickstrap.js -mc > dist/kickstrap/_core/js/kickstrap.min.js 
	@echo "Build complete."

test: 
	@echo "Clearing out previous folder..."
	@find . -name .DS_Store -exec rm -f {} \;
	@rm -rf tests/*
	@echo "Copying kickstrap folder..."
	@mkdir tests/kickstrap
	@cp -r lib/kickstrap/* tests/kickstrap/
	@cp -r lib/tests/* tests/
	@node build.js test
	@echo "Build complete."

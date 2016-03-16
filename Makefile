.PHONY: watch

WEBPACK = ./node_modules/.bin/webpack
WEBPACK_ARGS = --colors --progress
ELM_PACKAGE = elm-package

watch: elm-stuff
	$(WEBPACK) $(WEBPACK_ARGS) --watch

node_modules: package.json
	@npm install

elm-stuff: node_modules elm-package.json
	$(ELM_PACKAGE) install -y

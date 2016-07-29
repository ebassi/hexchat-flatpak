JSON_VALIDATE = $(shell which json-glib-validate)
FLATPAK = $(shell which flatpak)
FLATPAK_BUILDER = $(shell which flatpak-builder)

APPID = io.github.Hexchat
MANIFEST = $(APPID).json

# Use `make REPONAME=newname` to build to a separate repository
REPONAME ?= repo

# Use `make EXPORT_ARGS=--gpg-sign KEY` to sign during build
EXPORT_ARGS ?=
BUILDER_ARGS = --ccache --require-changes
UPDATE_REPO_ARGS = --prune --prune-depth=20

all: update-repo

build: $(MANIFEST)
	$(FLATPAK_BUILDER) \
		$(BUILDER_ARGS) \
		--repo=$(REPONAME) \
		--subject="Build of $(APPID), `date`" \
		$(EXPORT_ARGS) \
		app \
		$(MANIFEST)

update-repo: build
	$(FLATPAK) build-update-repo $(UPDATE_REPO_ARGS) $(EXPORT_ARGS) $(REPONAME)

check:
	$(JSON_VALIDATE) $(MANIFEST)

clean:
	@rm -rf app

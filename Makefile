JSON_VALIDATE = $(shell which json-glib-validate)
MANIFEST = io.github.Hexchat.json
BUILD = build.sh
UPDATE_REPO = update-repo.sh

all: update-repo

build: $(MANIFEST)
	sh $(BUILD) $(MANIFEST)

update-repo: build
	sh $(UPDATE_REPO)

check:
	$(JSON_VALIDATE) $(MANIFEST)

clean:
	rm -rf .flatpak-builder
	rm -rf app

MANIFEST = io.github.Hexchat.json
BUILD = build.sh
UPDATE_REPO = update-repo.sh

all: update-repo

build: $(MANIFEST)
	sh $(BUILD) $(MANIFEST)

update-repo: build
	sh $(UPDATE_REPO)

clean:
	rm -rf .flatpak-builder
	rm -rf app

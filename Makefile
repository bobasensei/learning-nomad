
VERSION=1.9.5

ifeq ($(shell uname -i), x86_64)
  ARCH=amd64
else
  ARCH=arm64
endif

ARCHIVE=nomad_$(VERSION)_linux_$(ARCH).zip

SOURCE=https://releases.hashicorp.com/nomad/$(VERSION)/$(ARCHIVE)

run:
	nomad agent -dev -bind=0.0.0.0

nomad:	$(ARCHIVE)
	unzip -o $(ARCHIVE) nomad

$(ARCHIVE):
	curl -O $(SOURCE)


apt:
	sudo apt install -u make unzip

clean:
	rm nomad $(ARCHIVE)


submodules:
	mkdir -p externals
 	git submodule add https://github.com/hashicorp-education/learn-nomad-getting-started externals/learn-nomad-getting-started
	git submodule update --init --recursive

update:
	git submodule update --init --recursive

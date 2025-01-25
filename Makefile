
VERSION=1.9.5

ifeq ($(shell uname -i), x86_64)
  ARCH=amd64
else
  ARCH=arm64
endif

ARCHIVE=nomad_$(VERSION)_linux_$(ARCH).zip

SOURCE=https://releases.hashicorp.com/nomad/$(VERSION)/$(ARCHIVE)

nomad:	$(ARCHIVE)
	unzip -o $(ARCHIVE) nomad

$(ARCHIVE):
	curl -O $(SOURCE)


apt:
	sudo apt install -u make unzip

clean:
	rm nomad $(ARCHIVE)

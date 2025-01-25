
VERSION=1.9.5

ifeq ($(shell uname -i), x86_64)
  ARCH=amd64
else
  ARCH=arm64
endif

ARCHIVE=nomad_$(VERSION)_linux_$(ARCH).zip

SOURCE=https://releases.hashicorp.com/nomad/$(VERSION)/$(ARCHIVE)

run:
	sudo nomad agent -dev -bind 0.0.0.0 -network-interface='{{ GetDefaultInterfaces | attr "name" }}'


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

DEMO=externals/learn-nomad-getting-started/jobs

demo:
	nomad job run $(DEMO)/pytechco-redis.nomad.hcl
	nomad job run $(DEMO)/pytechco-web.nomad.hcl
	nomad node status -verbose \
    		$(nomad job allocs pytechco-web | grep -i running | awk '{print $2}') | \
    		grep -i ip-address | awk -F "=" '{print $2}' | xargs | \
    		awk '{print "http://"$1":5000"}'
	nomad job run $(DEMO)/pytechco-setup.nomad.hcl
	nomad job dispatch -meta budget="200" pytechco-setup
	nomad job run $(DEMO)/pytechco-employee.nomad.hcl

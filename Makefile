.PHONY: default build clean

default: build

build: clean
	./build.sh
	
clean:
	@rm -rf $(CURDIR)/pkg

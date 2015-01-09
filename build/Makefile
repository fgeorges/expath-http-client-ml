VER=0.1.0
HCNAME=expath-http-client-ml
NAME=$(HCNAME)-$(VER)

build: clean
	mkdir "$(NAME)/src"
	mkdir "$(NAME)/test"
	cp README                    "$(NAME)"
	cp ../src/http-client.xq     "$(NAME)/src"
	cp ../test/marklogic-test.xq "$(NAME)/test"
	cp ../test/soap-test-ml.xq   "$(NAME)/test"
	tar cf "$(NAME).tar" "$(NAME)"
	gzip -9 "$(NAME).tar"
	zip -r "$(NAME).zip" "$(NAME)"

clean:
	rm -rf "$(NAME)"
	rm -rf "$(NAME).tar"
	rm -rf "$(NAME).tar.gz"
	rm -rf "$(NAME).zip"

.PHONY: build clean

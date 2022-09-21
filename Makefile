all:
	@echo Run "make build" to prepare the environment.
	@echo Run "make run" to fetch the sources.
	@echo Run "make clean" to remove the data and the image.
	@echo Run "make shell" to enter an intective shell.

build:
	podman build --pull --no-cache --squash --security-opt label=disable . -t autosd:sources

shell:
	podman run --rm -it -v ./outputs:/root/outputs autosd:sources bash

run:
	podman run --rm -v ./outputs:/root/outputs autosd:sources /root/get_sources.sh

clean:
	podman rmi -f autosd:sources
	rm -rf outputs/*

.PHONY: all clean build shell run

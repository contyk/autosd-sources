# autosd-sources
Gather sources for AutoSD product builds.

These tools provide a quick and dirty way to gather source files for
content included in AutoSD product builds.

## Usage
Build a local CentOS Stream-based image to collect your data with `make
build`.  Follow that with `make run` to populate the `outputs`
directory.

## Requirements
You will need `make` and `podman` installed, and roughly 25GB of free
space to store the outputs.

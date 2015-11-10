#!/bin/bash

docker build -t identity .
docker run \
	--volume $(pwd)/input/:/bbx/input/:ro \
	--volume $(pwd)/output:/bbx/output/:rw \
	identity \
	default

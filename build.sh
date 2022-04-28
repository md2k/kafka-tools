#!/usr/bin/env bash

#LATEST_VER="$(git describe --abbrev=0 2&> /dev/null | grep -Eo '[0-9]\.[0-9]+':-0.0)"
TAG=$(git describe --abbrev=0)
CURRENT_TAG=${TAG:-v0.0}
LATEST_VER="$(echo $CURRENT_TAG | grep -Eo '[0-9]\.[0-9]+')"
NEW_VER="$(echo $LATEST_VER+0.1 | bc | sed 's/^\./0./')"
NEW_TAG="v$NEW_VER"

echo $NEW_TAG

# Commit / Push / Tag
git add . && \
  git commit -am "update for kafka-tools build $NEW_TAG" && \
  git tag -a $NEW_TAG -m "update for kafka-tools build $NEW_TAG" && \
  git push --tags origin && \
  git push origin main && \
  git pull origin

CWD=${PWD}
for d in $(ls -1 | grep "^[0-9]*\.[0-9]*$"); do
	echo "Building image for kafka v$d with image tag $d-b$NEW_VER and git tag $NEW_TAG"
	cd ./$d && \
	ls -la && \
	docker build --no-cache -t md2k/kafka-tools:$d-b$NEW_VER -f ./Dockerfile .  && \
	docker tag md2k/kafka-tools:$d-b$NEW_VER md2k/kafka-tools:$d && \
	docker push md2k/kafka-tools:$d-b$NEW_VER && \
	docker push md2k/kafka-tools:$d-b$NEW_VER && \
	cd $CWD
done

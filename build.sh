#!/bin/sh

set -e

name=duzun/git
pwd=$(dirname "$(realpath "$0")")

docker build --no-cache -t $name:latest "$pwd"

version=$(docker run -it --rm $name:latest git version | cut -d" " -f3 | tr -d '\r\n ')
major=$(echo $version | cut -d'.' -f1)
minor=$(echo $version | cut -d'.' -f2)

echo
echo "version: $version"
echo

docker tag $name:latest $name:$version
docker tag $name:latest $name:$major.$minor
docker tag $name:latest $name:$major

if [ "$1" = "push" ]; then
    docker push $name
else 
    echo "To push run:"
    echo -e "\tdocker push $name"
fi

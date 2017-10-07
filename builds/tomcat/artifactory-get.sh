#!/bin/bash

# downloads latest version of an artifact from artifactory
# pulled from https://gist.github.com/suicide/b9d3a4f26a68f68de433
# had to modify the original script to add apikey and such


set -e

usage(){
  echo "Usage: $*" >&2
  exit 64
}

repo=""
group=""
artifact=""
classifier=""
apikey=""
while getopts r:g:a:k:c: OPT; do
  case "${OPT}" in
    r) repo="${OPTARG}";;
    g) group="${OPTARG}";;
    a) artifact="${OPTARG}";;
    k) apikey="${OPTARG}";;
    c) classifier="${OPTARG}";;
  esac
done
shift $(( $OPTIND - 1 ))

if [ -z "${repo}" ] || [ -z "${group}" ] || [ -z "${artifact}" ] || [ -z "${apikey}" ]; then
  usage "-r REPOSITORY -g GROUPID -a ARTIFACTID -k APIKEY [-c CLASSIFIER]"
fi

# Maven artifact location
ga=${group//./\/}/$artifact
repopath=$repo/$ga
header="X-JFrog-Art-Api: $apikey"
version=`curl -s -H "$header" $repopath/maven-metadata.xml | grep latest | sed "s/.*<latest>\([^<]*\)<\/latest>.*/\1/"`
build=`curl -s -H "$header" $repopath/$version/maven-metadata.xml | grep '<value>' | head -1 | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/"`

jar=""
if [ -z "${classifier}" ]; then
  jar=$artifact-$build.war
else
  jar=$artifact-$build-$classifier.war
fi

url=$repopath/$version/$jar

# Download
echo "Downloading $url as root.war"
curl -L -o root.war -H "$header" $url 


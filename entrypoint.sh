#!/bin/sh

docker_run="docker run"
docker_run="$docker_run -e POSTGRES_DB=$INPUT_POSTGRESQL_DB"
docker_run="$docker_run -e POSTGRES_USER=$INPUT_POSTGRESQL_USER"
docker_run="$docker_run -e POSTGRES_PASSWORD=$INPUT_POSTGRESQL_PASSWORD"

if [ ! -z "$INPUT_POSTGRESQL_INIT_SCRIPTS" ]
then
  PWD=`pwd`
  docker_run="$docker_run -v '$PWD/$INPUT_POSTGRESQL_INIT_SCRIPTS:/docker-entrypoint-initdb.d'"
fi

docker_run="$docker_run -d -p 5432:5432 'mdillon/postgis:$INPUT_POSTGRESQL_VERSION'"

echo "$docker_run"
sh -c "$docker_run"

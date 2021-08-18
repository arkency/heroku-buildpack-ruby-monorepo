#!/usr/bin/env bash

execute_buildpack () {
  local app_dir=$1
  local cache_dir=$2
  local env_dir=$3
  local buildpack_url=$4
  local outfile=$5
  local buildpack_dir=$(mktemp -d)

  curl -s $buildpack_url | tar xz -C $buildpack_dir

  local framework=$($buildpack_dir/bin/detect $app_dir)
  echo "-----> ${framework} app detected"

  $buildpack_dir/bin/compile $app_dir $cache_dir $env_dir
  $buildpack_dir/bin/release $app_dir > $outfile

  if [[ ! -e "${app_dir}/Procfile" ]]; then
    ruby -ryaml -e "puts YAML.dump(YAML.load_file('$outfile')['default_process_types'])" | tail +2 > "${app_dir}/Procfile"
  fi
}
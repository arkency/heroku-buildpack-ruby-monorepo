#!/usr/bin/env bash

require_env_variable () {
  local env_dir=$1
  local name=$2

  if [[ -z $(get_env_variable $env_dir $name) ]]; then
	  echo "${name} was not set, aborting." | indent
	  exit 1
  fi
}
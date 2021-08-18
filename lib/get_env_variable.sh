#!/usr/bin/env bash

get_env_variable () {
  local env_dir=$1
  local name=$2

  cat "${env_dir}/${name}"
}
#!/usr/bin/env bash

copy_app_json () {
  local build_dir=$1
  local relative_app_dir=$2

  if [[ -f "${build_dir}/${relative_app_dir}/app.json" ]]; then
	  cp "${build_dir}/${relative_app_dir}/app.json" "${build_dir}/app.json"
  fi
}
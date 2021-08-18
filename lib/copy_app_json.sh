#!/usr/bin/env bash

copy_app_json () {
  local build_dir=$1
  local src_app_dir=$(dirname "${build_dir}/${2}")

  if [[ -f "${src_app_dir}/app.json" ]]; then
	  cp "${src_app_dir}/app.json" "${build_dir}/app.json"
  fi
}
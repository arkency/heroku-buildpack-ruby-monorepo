#!/usr/bin/env bash

copy_procfile () {
  local build_dir=$1
  local procfile_path=$2
  local dst_app_dir=$(dirname "${HOME}/${procfile_path}")

  # copy to top-level in order for Heroku to recognize it
  cp "${build_dir}/${procfile_path}" "${build_dir}/Procfile"

  if ! [ $? ]; then
  	echo "Failed to copy Procfile, aborting." | indent
  	exit 1
  fi

  # replace relative paths (i.e. bin/rails) with absolute ones (such as /app/rails_application/bin/rails)
  sed -i -r -e "s|(bin/[a-z]+)|${dst_app_dir}/\1|g" "${build_dir}/Procfile"
}
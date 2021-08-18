#!/usr/bin/env bash

copy_procfile () {
  local build_dir=$1
  local relative_app_dir=$2

  # copy to top-level in order for Heroku to recognize it
  cp "${build_dir}/${relative_app_dir}/Procfile" "${build_dir}/Procfile"

  if [[ $? != 0 ]]; then
  	echo "Failed to copy Procfile, aborting." | indent
  	exit 1
  fi

  # replace relative paths (i.e. bin/rails) with absolute ones (such as /app/rails_application/bin/rails)
  sed -i -r -e "s|(bin/[a-z]+)|${HOME}/${relative_app_dir}/\1|g" "${build_dir}/Procfile"
}
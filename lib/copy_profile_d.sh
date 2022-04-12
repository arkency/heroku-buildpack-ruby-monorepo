#!/usr/bin/env bash

copy_profile_d () {
  local build_dir=$1
  local relative_app_dir=$2

  # move to top-level so that Heroku sources it
  mkdir -p "${build_dir}/.profile.d"
  
  cp ${build_dir}/${relative_app_dir}/.profile.d/* ${build_dir}/.profile.d/ 2>/dev/null

  if [[ $? != 0 ]]; then
	  echo "Failed to write .profile.d scripts, aborting." | indent
	  exit 1
  fi

  # fix related paths to point to subdirectory where application lives
  sed -i -e "s|\$HOME/|\$HOME/${relative_app_dir}/|g" "${build_dir}/.profile.d/"*
}

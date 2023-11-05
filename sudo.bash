#!/bin/bash

# This script is used to run doas instead of sudo.
# It is called sudo, so it maps all arguments to doas
# and then runs doas with the mapped arguments.
# See https://github.com/ubermanu/sudoas

version="1.1"

# shellcheck disable=SC2034
yellow=$(tput setaf 3)
end=$(tput sgr0)
# shellcheck disable=SC2034

# If TEST is set to 1, the script will output the arguments
TEST=${TEST:-0}

# Parse arguments
doas_args=()
doas_env=()
parse_env=1

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -h | --help)
    echo "${yellow}THIS IS A COMPATIBILITY SCRIPT FOR DOAS.${end}"
    echo "Usage: sudo [options] [command]"
    exit 0
    ;;
  -V | --version)
    echo "${yellow}THIS IS A COMPATIBILITY SCRIPT FOR DOAS.${end}"
    echo "Version: ${version}"
    exit 0
    ;;
  -n | --non-interactive)
    doas_args+=(-n)
    shift
    ;;
  -s | --shell)
    doas_args+=(-s)
    shift
    ;;
  -s=* | --shell=*)
    doas_args+=(-s "${key#*=}")
    shift
    ;;
  -u | --user)
    doas_args+=(-u)
    shift
    ;;
  -u=* | --user=*)
    doas_args+=(-u "${key#*=}")
    shift
    ;;
  -p | --prompt)
    # not supported
    shift
    shift
    ;;
  -c | --command)
    # not supported
    shift
    shift
    ;;
  -* | --*)
    # Ignore unsupported options
    # Match any option that starts with - or --
    # and any option that starts with -- and contains an =
    shift
    ;;
  *)
    # If not a sudo argument, assume it's a command and arguments
    # or an environment variable
    if [ $parse_env -eq 1 ] && [[ $key == *=* ]]; then
      doas_env+=("$key")
      shift
    else
      parse_env=0
      doas_args+=("$@")
      break
    fi
    ;;
  esac
done

# If there are no arguments, output help
if [[ ${#doas_args[@]} -eq 0 ]]; then
  echo "${yellow}THIS IS A COMPATIBILITY SCRIPT FOR DOAS.${end}"
  echo "Usage: sudo [options] [command]"
  exit 0
fi

# If TEST is set to 1, output the arguments and exit
if [[ $TEST -eq 1 ]]; then
  echo "${doas_args[*]}"
  exit 0
fi

# Run doas with environment variables and arguments
for env_var in "${doas_env[@]}"; do
  export "$env_var"
done

doas "${doas_args[@]}"

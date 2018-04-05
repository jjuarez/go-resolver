#!/bin/bash


declare -r PACKAGE="netdns"
declare -r DEFAULT_DEBUG_LEVEL=2
declare -r DEFAULT_TARGET_HOST="sts.amazonaws.com"

TARGET_HOST="${1:-${DEFAULT_TARGET_HOST}}"
DEBUG_LEVEL="${2:-${DEFAULT_DEBUG_LEVEL}}"


utils::console( ) {
  local message="${1}"

  [[ -n "${message}" ]] && echo -e "${message}"
}


utils::die( ) {
  local message="${1}"
  local exit_code=${2:-0}

  utils::console "${message}"
  exit ${exit_code}
}


test::dns( ) {
  local target_host="${1}"
  local dns_resolution="${2}"
  local dns_resolution_pretty="${3}"

  utils::console "Testing DNS support type: ${dns_resolution_pretty}:"
  GODEBUG="${PACKAGE}=${dns_resolution}+${DEBUG_LEVEL}" "${GOPATH}/bin/resolver" -host="${TARGET_HOST}"
  utils::console "---\n"
}

#
# ::main::
#
[[ -n "${GOPATH}"              ]] || utils::die "You should to define the GOPATH variable pointing to the root of this project" 1
[[ -x "${GOPATH}/bin/resolver" ]] || utils::die "you should to generate the binary executing: make" 2

test::dns "${TARGET_HOST}" "go" "Go native"
test::dns "${TARGET_HOST}" "cgo" "System"

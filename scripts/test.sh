#!/bin/sh

declare -r DEFAULT_DEBUG_LEVEL=2
declare -r DEFAULT_TARGET_HOST="sts.amazonaws.com"

TARGET_HOST="${1:-${DEFAULT_TARGET_HOST}}"
DEBUG_LEVEL="${2:-${DEFAULT_DEBUG_LEVEL}}"

echo "Testing with go DNS support:"
GODEBUG="netdns=go+${DEBUG_LEVEL}" ../bin/resolver -host="${TARGET_HOST}"

echo "Testing with cgo system DNS support:"
GODEBUG="netdns=cgo+${DEBUG_LEVEL}" ../bin/resolver -host="${TARGET_HOST}"

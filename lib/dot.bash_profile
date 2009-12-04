#!/bin/sh -xv

# Getting the path of the project
if [ ! -z "${BASH_ARGV[0]}" ]; then
	__FILE__="${BASH_ARGV[0]}"
else
	__FILE__="${0}"
fi

export BASH_SCRIPTS_PATH=`cd \`dirname $(readlink ${__FILE__} || echo ${__FILE__} )\`/..; pwd`
export BASH_SCRIPTS_LIBS="${BASH_SCRIPTS_PATH}/lib"
export BASH_SCRIPTS_PRIV="${BASH_SCRIPTS_PATH}/private"

# Function debug
function debug {
	if [ -n "${BASH_SCRIPTS_DEBUG}" ]; then
		echo $1
	fi
}

# Load SO conditional configure and common
source "${BASH_SCRIPTS_LIBS}/$(echo "$(uname)" | awk '{ print tolower($0) }').bash"
source $BASH_SCRIPTS_LIBS/common.bash

# Run configuration
before_common "$@"
common_configure "$@"
after_common "$@"

# Private configure
if [[ -f $BASH_SCRIPTS_PRIV/private.bash ]]; then
	source $BASH_SCRIPTS_PRIV/private.bash
fi
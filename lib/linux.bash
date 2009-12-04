#!/bin/sh

debug "Load linux bash configure"

# Linux configure	
function before_common {
	export EDITOR="vim"
	alias ls='ls --color=auto'

	alias which='which 2> /dev/null'
}

function after_common {
	echo ""
}
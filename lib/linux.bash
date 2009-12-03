#!/bin/sh

# Linux configure	
function before_common {
	export EDITOR="vim"
	alias ls='ls --color=auto'
}

function after_common {
	echo ""
}
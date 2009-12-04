#!/bin/sh

debug "Load darwin bash configure"

function before_common {
	# Mac OS X configure
	export EDITOR='tvim'
	alias ls='ls -G'
	
	# Language em character set
	export LC_ALL=pt_BR.UTF-8
	export LANG=pt_BR.UTF-8

	# Paths
	export PATH=~/.gem/ruby/1.8/bin:$PATH
	export PATH=~/Library/apache2/bin:$PATH
	export PATH=/usr/local/mysql/bin:$PATH
	export PATH=/usr/local/scala-2.7.5.final/bin:$PATH
	export PATH=/opt/local/bin:$PATH
}

function after_common {
	# Completations bash
	if [ -f /opt/local/etc/bash_completion ]; then
	    . /opt/local/etc/bash_completion
	fi

	# Java env configuration
	export JAVA_HOME=`/usr/libexec/java_home`
	export DYLD_LIBRARY_PATH="$JAVA_HOME/lib:$DYLD_LIBRARY_PATH"

	# Tomcat
	export CATALINA_HOME=/Library/Tomcat/Home

	# Go language
	export GOROOT=~/Projetos/estudo/go/downloads/go
	export GOS=darwin
	export GOARCH=amd64

	# Maglev
	export MAGLEV_HOME=~/Projetos/estudo/ruby/downloads/maglev
	export PATH=$MAGLEV_HOME/bin:$PATH
	
	# Oracle
	export DYLD_LIBRARY_PATH="/opt/oracle/instantclient_10_2:$DYLD_LIBRARY_PATH"
	export TNS_ADMIN=/opt/oracle/tns
}
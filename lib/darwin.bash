#!/bin/sh

debug "Load darwin bash configure"

function before_common {
	# Mac OS X configure
	export EDITOR='mate'
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
	export PATH=/opt/erlang/current/bin:$PATH
	export PATH=/usr/local/Cellar/android-sdk/r6/tools:$PATH
	export PATH=/usr/local/Cellar/android-sdk/r6/platforms/android-3/tools:$PATH
	
	# New environment setting added by Symbian ADT Sourcery G++ Lite for ARM SymbianOS on Wed May 05 19:26:46 BRT 2010 1.
	# The unmodified version of this file is saved in /Users/eribeiro/.bash_profile86656300.
	# Do NOT modify these lines; they are used to uninstall.
	PATH="/Applications/CodeSourcery/Sourcery G++ Lite/bin:${PATH}"
	export PATH
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
	
	# Android
	export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r6
}
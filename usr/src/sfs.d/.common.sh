#!/bin/sh

: ${lbu:=/opt/LiveBootUtils}
. "$lbu/scripts/common.func"

: ${locale:=en-US}
: ${arch:=$(uname -m)}
: ${name:=thunderbird}
: ${inst_path:=opt}
: ${app_ini:=$DESTDIR/$inst_path/$name/application.ini}

: ${redirector_url:=https://download.mozilla.org/?product=${name}-latest&os=linux64&lang=$locale}

latest_url() {
  curl -s -I "$redirector_url" | awk '/^Location: /{print $2}' | tr -d \\r
}

latest_version() {
  local ret
  ret="$(basename $(latest_url) .tar.bz2)"
  echo "${ret#$name-}"
}

#!/usr/bin/env bash
set -Eeo pipefail

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'UBUNTU_USER'
file_env 'UBUNTU_PW'

if [ -z "$UBUNTU_USER" ]; then
  UBUNTU_USER=ubuntu
fi

if [ -z "$UBUNTU_PW" ]; then
  UBUNTU_PW=ubuntu
fi

useradd -u 1000 -G users,sudo,root -d /home/$UBUNTU_USER --shell /bin/bash -m $UBUNTU_USER && \
usermod -p $UBUNTU_PW $UBUNTU_USER

exec "$@"

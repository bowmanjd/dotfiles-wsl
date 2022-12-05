#!/bin/sh

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR=/run/user/$UID
  if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp/$USER-runtime
    if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
      mkdir -m 0700 "$XDG_RUNTIME_DIR"
    fi
  fi
fi

export DOCKER_DISTRO="fedora"
DOCKER_DIR=/mnt/wsl/shared-docker
DOCKER_SOCK="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCK"
if [ ! -S "$DOCKER_SOCK" ]; then
    mkdir -pm o=,ug=rwx "$DOCKER_DIR"
    chgrp docker "$DOCKER_DIR"
		cd /mnt/c
    /mnt/c/Windows/System32/wsl.exe -d "$DOCKER_DISTRO" sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
		cd "$OLDPWD"
fi

PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'


export GIT_CONFIG_COUNT=2
export GIT_CONFIG_KEY_0=user.signingkey
export GIT_CONFIG_VALUE_0=5B9B18A4E30AE070
export GIT_CONFIG_KEY_1=user.email
export GIT_CONFIG_VALUE_1=jbowmancargas@users.noreply.github.com


# WINHOSTS="/mnt/c/Windows/System32/drivers/etc/hosts"
# ip=$(ip addr show label eth0 | rg -ow 'inet ([^/]+)' -r '$1')
# 
# if ! rg -q --crlf "$ip" /mnt/c/Windows/System32/drivers/etc/hosts; then
# 	tmpfile=$(mktemp)
# 	rg --crlf -v '^\d{1,3}(\.\d{1,3}){3}\s+wsl' "$WINHOSTS" > "$tmpfile"
# 	printf "$ip    wsl\r\n" >> "$tmpfile"
# 	$HOME/win/scoop/shims/sudo.exe pwsh -Command 'mv -Force '$(wslpath -w $tmpfile)' C:\Windows\System32\drivers\etc\hosts'
# 	unset tmpfile
# fi
# 
# unset ip


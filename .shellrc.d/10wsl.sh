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

PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'

WINHOSTS="/mnt/c/Windows/System32/drivers/etc/hosts"
ip=$(ip addr show label eth0 | rg -ow 'inet ([^/]+)' -r '$1')

if ! rg -q --crlf "$ip" /mnt/c/Windows/System32/drivers/etc/hosts; then
	tmpfile=$(mktemp)
	rg --crlf -v '^\d{1,3}(\.\d{1,3}){3}\s+wsl' "$WINHOSTS" > "$tmpfile"
	printf "$ip    wsl\r\n" >> "$tmpfile"
	$HOME/win/scoop/shims/sudo.exe pwsh -Command 'mv -Force '$(wslpath -w $tmpfile)' C:\Windows\System32\drivers\etc\hosts'
	unset tmpfile
fi

unset ip


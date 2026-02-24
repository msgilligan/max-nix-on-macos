#!/bin/zsh
# Simple script to set macOS hostname (3 different ones!) before running nix-darwin install
NAME="${1:-max}"
scutil --set ComputerName "${(C)NAME} Nix-Darwin"   # User-friendly name for Finder, etc.
scutil --set HostName "${NAME}"                     # Hostname used by local network and shell
scutil --set LocalHostName "${NAME}"                # Bonjour/mDNS name

dscacheutil -flushcache
killall -HUP mDNSResponder

echo "---"
echo "Success! Current configuration:"
echo "ComputerName:  $(scutil --get ComputerName)"
echo "HostName:      $(scutil --get HostName)"
echo "LocalHostName: $(scutil --get LocalHostName)"

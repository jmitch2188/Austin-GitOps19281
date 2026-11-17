#!/bin/sh
#
# Point every network service on this Mac at Cloudflare DNS (1.1.1.1).
#
# Run by Fleet as root when the "macOS - DNS resolves through Cloudflare (1.1.1.1)"
# policy fails. Safe to run repeatedly: setting the same servers again changes nothing.

status=0

services=$(networksetup -listallnetworkservices | tail -n +2 | grep -v '^\*')

while IFS= read -r service; do
  [ -n "$service" ] || continue
  if networksetup -setdnsservers "$service" 1.1.1.1; then
    echo "Set DNS for '$service' to 1.1.1.1"
  else
    echo "Failed to set DNS for '$service'" >&2
    status=1
  fi
done <<EOF
$services
EOF

# Drop cached answers from the old resolvers.
dscacheutil -flushcache
killall -HUP mDNSResponder 2>/dev/null || true

exit "$status"

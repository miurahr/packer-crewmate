#! /bin/bash
set -e

# clean apt caches
apt-get clean
rm -f /var/cache/apt/pkgcache.bin
rm -f /var/cache/apt/srcpkgcache.bin
find /var/lib/apt/lists/ -type f -exec rm -f {} \;

rm -rf /tmp/crewmate

if [ -d /tmp/supervisor ]; then
  rm -rf /tmp/supervisor
fi

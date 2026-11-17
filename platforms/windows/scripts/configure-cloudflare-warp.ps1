# Placeholder: configure Cloudflare WARP after it is installed.
#
# Fleet runs this as the post-install script for Cloudflare WARP on Windows
# hosts in the "Personal mobile devices" fleet. Replace the body with the real
# configuration (for example warp-cli registration and connect commands).

Write-Output @'

      /\_/\
     ( o.o )   WARP is installed!
      > ^ <    Real configuration goes here.
     /|   |\
    (_|   |_)

'@

exit 0

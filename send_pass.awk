#!/usr/bin/env awk -f
BEGIN {
  FS="\t"
  domain=ENVIRON["DOMAIN"]
}
{
  print("Send password for "$2" to "$1)
  system("mutt -x -s \"[ ⚠️ IMPORTANT][VPN] vpn password for "$2"\" "$1" vpn@"domain" <<< \"Your vpn user is "$2"\nand your vpn password is "$3"\"")
  system("sleep 5")
}
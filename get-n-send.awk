#!/usr/bin/env awk -f
BEGIN {
  FS="\t"
  domain=ENVIRON["DOMAIN"]
  targets=ENVIRON["TARGETS"]
}
{
  print("Downloading config files for "$2" and sending them to "$1)
  split(targets,arr_targets,",")
  for (target in arr_targets) {
    system("./download-configs.sh "arr_targets[target]" "$2) 
  }
  # to add check if vpn configs are valid
  system("mutt -x -s \"[ ⚠️ IMPORTANT][VPN] account settings for "$2"\" -a configs/*.ovpn -a vpn-setup.pdf -- "$1" vpn@"domain" < ./email-body.txt")
  system("rm -f configs/*-"$2".ovpn")
}

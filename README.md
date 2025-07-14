## Send renewed ovpn-admin credentials to users

### Prerequisites

1. Renew all certificates with the script `vpn-renew.sh`, after copying it to the efs mount which maps to `/etc/openvpn/easyrsa`.
   Also do not forget to do `chmod +x vpn-renew.sh`

2. Install and configure mutt and msmtp on your local host like:

   Create log dir:

   `mkdir -p /Users/xxx/log/`

   Muttrc `~/.muttrc`
   ```
   set sendmail="/opt/homebrew/bin/msmtp -a xxx"
   set from="XXX <xxx@xxx.xxx>"
   set editor="nano -t +8 -r 72 -b"
   ```

   Msmtprc `~/.msmtprc`
   ```
   defaults
   syslog off
   aliases /etc/aliases
   logfile /Users/xxx/log/mail.log

   account xxx
   host smtp.gmail.com
   port 587
   protocol smtp
   domain xxx
   auth login
   user xxx@xxx
   password yyy
   ntlmdomain xxx
   tls on
   # tls_min_dh_prime_bits 512
   tls_certcheck off
   auto_from off
   from xxx@xxx.xxx
   maildomain xxx.xxx
   ```

### Steps

1. Get the users list from the spreadsheet and have 3 columns: email, username, password, all separated by TAB
   
   TODO: script auto-reset of password

2. Create env:
   
   ```
   cp example.env .env
   nano .env
   ```

3. Run `./get-n-send.awk list.csv`

4. Run `./send_pass.awk list.csv`

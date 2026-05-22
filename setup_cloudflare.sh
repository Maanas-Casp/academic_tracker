#!/bin/bash

# This script configures Apache (httpd) on AWS EC2 to correctly identify 
# the original visitor IPs when traffic is proxied through Cloudflare.

echo "Setting up Cloudflare mod_remoteip for Apache..."

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo ./setup_cloudflare.sh)"
  exit 1
fi

# Configuration file path for httpd
CONF_FILE="/etc/httpd/conf.d/cloudflare.conf"

echo "Fetching latest Cloudflare IPs..."
IPV4=$(curl -s -L https://www.cloudflare.com/ips-v4)
IPV6=$(curl -s -L https://www.cloudflare.com/ips-v6)

if [ -z "$IPV4" ]; then
    echo "Error fetching Cloudflare IPv4 list. Aborting."
    exit 1
fi

echo "Creating Apache configuration..."
cat > $CONF_FILE << EOF
# Cloudflare mod_remoteip Configuration
# Restores the original visitor IP in the Apache logs and for PHP applications.

<IfModule remoteip_module>
    RemoteIPHeader CF-Connecting-IP
EOF

for ip in $IPV4; do
    echo "    RemoteIPTrustedProxy $ip" >> $CONF_FILE
done

for ip in $IPV6; do
    echo "    RemoteIPTrustedProxy $ip" >> $CONF_FILE
done

cat >> $CONF_FILE << EOF
</IfModule>

# Log format update to use %a instead of %h for the real IP
LogFormat "%a %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
EOF

echo "Cloudflare configuration saved to $CONF_FILE."

# Restart Apache to apply changes
echo "Restarting Apache..."
systemctl restart httpd

echo "=================================================="
echo "Success! Apache is now configured for Cloudflare."
echo "Your PHP applications will now see the real visitor IPs."
echo "=================================================="

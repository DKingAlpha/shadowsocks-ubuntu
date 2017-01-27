#!/bin/bash

ssinstdir="$(cd $(dirname $0) && pwd)"
cd $ssinstdir

if [ `uname -p` != 'x86_64' ]; then
    echo "Ubuntu/Debian 64bit required! Exiting..."
    exit 1
fi

if [ `id -u` != '0' ]; then
    echo "root permission required! Please run as root. Exiting..."
    exit 1
fi


read -p "Shadowsocks Server IP   >" SS_IP
read -p "Shadowsocks Server Port >" SS_PORT
read -p "Shadowsocks Password    >" YOURPASSWORD

cp config/ss.conf.tpl config/ss.conf
sed -i "s/SS_IP/$SS_IP/g" config/ss.conf
sed -i "s/SS_PORT/$SS_PORT/g" config/ss.conf
sed -i "s/YOURPASSWORD/$YOURPASSWORD/g" config/ss.conf



echo "
         Encrypting Method is set to 'aes-256-cfb' as default,
         (If not right , please manually fix 'config/ss.conf' now ),
         Then hit ENTER key to continue.
"
read junk


echo "The SS config file looks like:"
cat config/ss.conf
echo "Hit Enter to begin automitically installation."

dpkg -R -i debfiles

mv /etc/polipo/config /etc/polipo/config.bak
mv /etc/shadowsocks-libev/config.json /etc/shadowsocks-libev/config.json.bak
cp config/polipo.conf /etc/polipo/config
cp config/ss.conf /etc/shadowsocks-libev/config.json
cp -r acl_list /etc/shadowsocks-libev/
echo "bypass-lan-china.acl" > /etc/shadowsocks-libev/acl_selection
update-rc.d polipo disable >/dev/null 2>/dev/null

chmod +x Shadowsocks
rm /usr/bin/Shadwosocks 2>/dev/null
ln -s $ssinstdir/Shadowsocks /usr/bin/Shadwosocks 2>/dev/null





echo "
    Installation Completed!
    Now you can run Shadowsocks at any terminal.
"


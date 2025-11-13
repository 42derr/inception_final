#!/bin/bash
set -e

FTP_PASS=$(cat "$FTP_PASS_FILE")

if ! id "$FTP_USER" &>/dev/null; then
    echo "Creating FTP user $FTP_USER..."
    useradd -m -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    mkdir -p /home/"$FTP_USER"/ftp
    chown -R "$FTP_USER":"$FTP_USER" /home/"$FTP_USER"
    chmod -R 755 /home/"$FTP_USER"
    usermod -aG www-data "$FTP_USER"
fi

echo "Starting vsftpd..."
exec vsftpd /etc/vsftpd.conf

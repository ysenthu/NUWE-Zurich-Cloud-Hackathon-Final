#!/bin/bash
mkdir -p /opt/app
aws s3 cp s3://${bucket_name}/package.zip /opt/package.zip
unzip /opt/package.zip -d /opt/app
pip3 install flask
cp /opt/app/app.service /etc/systemd/system/app.service
sed -i "s/REPLACED/${bucket_name}/g" /etc/systemd/system/app.service
systemctl enable app.service
systemctl start app.service
#!/bin/bash
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

cd /opt
git clone https://github.com/gganster/stress-test.git
cd stress-test
npm install

cat > /etc/systemd/system/stress-test.service << EOF
[Unit]
After=network.target

[Service]
ExecStart=/usr/bin/node /opt/stress-test/index.js
Restart=always
Environment=PORT=8080

[Install]
WantedBy=multi-user.target
EOF

systemctl enable stress-test
systemctl start stress-test

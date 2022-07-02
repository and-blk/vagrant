#!/bin/bash

INFO='\e[0;34mINFO:\e[0m'

echo -e "${INFO} fix containerd configuration file"

cat > /etc/containerd/config.toml <<EOF
[plugins."io.containerd.grpc.v1.cri"]
  systemd_cgroup = true
EOF

echo -e "${INFO} restart containerd daemon"
systemctl restart containerd

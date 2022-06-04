file "/etc/sysctl.conf" do
  action :edit
  block do |content|
    content << "
# Setting by itamae
net.ipv4.ip_local_port_range = 1024 65535
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_wmem=4096 65536 16777216
net.ipv4.tcp_fin_timeout = 30
net.core.netdev_max_backlog = 30000
net.ipv4.tcp_no_metrics_save=1
net.core.somaxconn = 262144
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_max_orphans = 65535
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_tw_reuse = 1\n"
  end
  not_if 'grep -q "# Setting by itamae" /etc/sysctl.conf'
end
execute "sysctl -p; true"

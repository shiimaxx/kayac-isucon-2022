execute "wget -O netdata-kickstart.sh https://my-netdata.io/kickstart.sh" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/netdata-kickstart.sh"
end

execute "sh netdata-kickstart.sh" do
  cwd "/usr/local/src"
  not_if "test -e /etc/netdata"
end

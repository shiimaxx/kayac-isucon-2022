version = "v0.11.59"

execute "wget https://github.com/k0kubun/sqldef/releases/download/#{version}/mysqldef_linux_amd64.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/mysqldef_linux_amd64.tar.gz"
end

execute "tar zxf /usr/local/src/mysqldef_linux_amd64.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/mysqldef"
end

remote_file "/usr/local/bin/mysqldef" do
  source "/usr/local/src/mysqldef"
  mode "0755"
  owner "root"
  group "root"
end

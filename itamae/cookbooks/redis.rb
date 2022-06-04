version = "6.2.5"

packages = %w(
  libjemalloc-dev
  libhiredis-dev
  liblua5.3-dev
)

packages.each do |p|
    package p
end

execute "wget https://download.redis.io/releases/redis-#{version}.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/redis-#{version}.tar.gz"
end

execute "tar zxf /usr/local/src/redis-#{version}.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/redis-#{version}"
end

execute "make hiredis && make lua && make jemalloc && make linenoise" do
  cwd "/usr/local/src/redis-#{version}/deps"
  not_if "test -e /usr/local/src/redis-#{version}/deps/hiredis/libhiredis.a"
end

execute "make && make install" do
  cwd "/usr/local/src/redis-#{version}"
  not_if "test -e /usr/local/bin/redis-server"
end

directory "/etc/redis" do
  mode "0755"
  owner "root"
  group "root"
end

directory "/var/run/redis" do
  mode "0750"
  owner "root"
  group "root"
end

remote_file "/etc/redis/6379.conf" do
  mode "0644"
  owner "root"
  group "root"
end

remote_file "/etc/systemd/system/redis.service" do
  mode "0644"
  owner "root"
  group "root"
end

remote_file "/etc/systemd/system/redis-save.service" do
  mode "0644"
  owner "root"
  group "root"
end

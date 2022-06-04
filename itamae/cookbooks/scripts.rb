directory "/opt/scripts" do
  mode "0755"
  owner "root"
  group "root"
end

scripts = %w(
  make_mysql_info.sh
  post_bench.sh
  pre_bench.sh
  restart.sh
)

scripts.each do |s|
  remote_file "/opt/scripts/#{s}" do
    mode "0755"
    owner "root"
    group "root"
  end
end

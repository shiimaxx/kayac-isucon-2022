["backup", "logs"].each do |d|
  directory "/opt/#{d}" do
    mode "0777"
    owner "root"
    group "root"
  end
end

directory "/tmp/profile" do
  mode "0777"
  owner "root"
  group "root"
end

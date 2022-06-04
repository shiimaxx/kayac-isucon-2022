version = "v0.4.2"

execute "wget https://github.com/matsuu/kataribe/releases/download/#{version}/kataribe-#{version}_linux_amd64.zip" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/kataribe-#{version}_linux_amd64.zip"
end

execute "unzip /usr/local/src/kataribe-#{version}_linux_amd64.zip" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/kataribe"
end

remote_file "/usr/local/bin/kataribe" do
  source "/usr/local/src/kataribe"
  mode "0755"
  owner "root"
  group "root"
end

execute "kataribe -generate" do
  cwd "/opt"
  not_if "test -e /opt/kataribe.toml"
end

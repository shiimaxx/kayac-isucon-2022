version = "v0.4.11"

execute "wget https://github.com/catatsuy/notify_slack/releases/download/#{version}/notify_slack-linux-amd64.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/notify_slack-linux-amd64.tar.gz"
end

execute "tar zxf /usr/local/src/notify_slack-linux-amd64.tar.gz" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/notify_slack"
end

remote_file "/usr/local/bin/notify_slack" do
  source "/usr/local/src/notify_slack"
  mode "0755"
  owner "root"
  group "root"
end

remote_file "/etc/notify_slack.toml" do
  mode "0644"
  owner "root"
  group "root"
end

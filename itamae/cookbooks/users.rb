node[:users].each do |u|
  USER_NAME = u[:name]
  user u[:name] do
    action :create
    shell "/bin/bash"
  end
  directory "/home/#{USER_NAME}/.ssh" do
    mode "0700"
    owner u[:name]
    group u[:name]
  end
  file "/home/#{USER_NAME}/.my.cnf" do
    mode "0600"
    owner u[:name]
    group u[:name]
  end
  http_request "authorized_keys" do
    url u[:authorized_keys]
    path "/home/#{USER_NAME}/.ssh/authorized_keys"
    mode "0600"
    owner u[:name]
    group u[:name]
  end
  remote_file "/home/#{USER_NAME}/.tmux.conf" do
      mode "0644"
      owner u[:name]
      group u[:name]
  end
  remote_file "/etc/sudoers.d/#{USER_NAME}" do
    mode "0440"
    owner "root"
    group "root"
  end
  remote_file "/home/#{USER_NAME}/.gitconfig" do
    mode "0644"
    owner u[:name]
    group u[:name]
  end
  [".bashrc", ".bash_logout", ".profile"].each do |f|
    remote_file "/home/#{USER_NAME}/#{f}" do
      source "/etc/skel/#{f}"
      mode "0644"
      owner u[:name]
      group u[:name]
    end
  end
end

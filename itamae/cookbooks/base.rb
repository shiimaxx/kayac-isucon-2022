execute "apt update" do
  not_if "test $(find /var/cache/apt/archives -type d -mtime -1 | wc -l) -gt 0"
end

packages = %w(
  language-pack-ja
  dstat
  telnet
  htop
  iotop
  jq
  lsof
  mlocate
  tmux
  wget
  make
  man
  sysstat
  bash-completion
  graphviz
  vim
  unzip
  pkg-config
)

packages.each do |p|
    package p
end

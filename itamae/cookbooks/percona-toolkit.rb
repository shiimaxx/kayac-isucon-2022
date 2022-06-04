execute "wget https://repo.percona.com/apt/percona-release_latest.generic_all.deb" do
  cwd "/usr/local/src"
  not_if "test -e /usr/local/src/percona-release_latest.generic_all.deb"
end

package "/usr/local/src/percona-release_latest.generic_all.deb" do
  not_if "test -e /etc/apt/sources.list.d/percona-original-release.list"
end

package "percona-toolkit"

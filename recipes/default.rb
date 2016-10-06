# ==================================================
# Java setup
# ==================================================
include_recipe 'java::default'

# ==================================================
# Setup OS users and groups
# ==================================================
group 'xlrelease' do
  action :create
  group_name node['xlr']['group']
end

# ==================================================
# This user will run XL Release
# ==================================================
user 'xlrelease' do
  action :create
  username  node['xlr']['user']
  gid       node['xlr']['group']
  comment   'XL Release system user'
  system    true
  shell     '/bin/false'
end

# ==================================================
# Download XL Release install zip
# ==================================================
remote_file "#{node['xlr']['installdir']}/#{node['xlr']['filename']}" do
  source node['xlr']['downloadurl']
end

# ==================================================
# Unzip install zip
# ==================================================
package 'unzip' do
  action :install
end
execute 'unzip installation archive' do
  command "unzip #{node['xlr']['installdir']}/#{node['xlr']['filename']} -d #{node['xlr']['installdir']}"
end

# ==================================================
# Chown install directory
# ==================================================
execute 'update ownership' do
  command "chown -R xlrelease:xlrelease #{node['xlr']['home']}"
end

# ==================================================
# Create the input file for the installer
# ==================================================
template 'setup-config' do
  source  'setup-config.txt.erb'
  path    "#{node['xlr']['home']}/setup-config.txt"
  owner   node['xlr']['user']
  group   node['xlr']['group']
  mode    '0600'
  variables(
    adminpassword: node['xlr']['adminpassword'],
    repository: node['xlr']['repository'],
    threads: node['xlr']['threads'],
    ssl: node['xlr']['ssl'],
    csre: node['xlr']['csre'],
    http_bind: node['xlr']['http_bind'],
    http_context_root: node['xlr']['http_context_root'],
    threads_max: node['xlr']['threads_max'],
    cstm: node['xlr']['cstm'],
    hide_internals: node['xlr']['hide_internals'],
    import_packages: node['xlr']['import_packages'],
    port: node['xlr']['port']
  )

  notifies :run, 'execute[install-xlrelease]', :immediately
end

# ==================================================
# Run the installer
# ==================================================
execute 'install-xlrelease' do
  user    node['xlr']['user']
  group   node['xlr']['group']
  cwd     "#{node['xlr']['home']}/bin"
  command "./server.sh -setup -reinitialize -force -setup-defaults #{node['xlr']['home']}/setup-config.txt &> #{node['xlr']['home']}/install.log"
  creates "#{node['xlr']['home']}/install.log"
  action :nothing
end

# ==================================================
# Runit configuration
# ==================================================
include_recipe 'runit::default'

# ==================================================
# Create the service resource
# ==================================================
runit_service 'xlrelease' do
  sv_dir '/etc/sv'
  service_dir '/etc/service'
  owner node['xlr']['user']
  group node['xlr']['group']
end

directory '/etc/sv/xlrelease/control' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/sv/xlrelease/control/d' do
  source 'sv-xlrelease-java-down.erb'
  owner 'root'
  group 'root'
  mode '0744'
end

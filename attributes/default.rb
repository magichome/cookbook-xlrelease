# ==================================================
# XL Release version to install
# ==================================================
default['xlr']['version'] = '5.0.1'

# ==================================================
# Home directory for XL Release
# ==================================================
default['xlr']['installdir'] = '/opt'
default['xlr']['home'] = "#{node['xlr']['installdir']}/xl-release-#{node['xlr']['version']}-server"

# ==================================================
# The user/group to run as
# ==================================================
default['xlr']['user'] = 'xlrelease'
default['xlr']['group'] = 'xlrelease'

# ==================================================
# Below attributes used to setup-config.txt for input into xlrelease installer
# ==================================================
default['xlr']['adminpassword'] = 'password'
default['xlr']['repository'] = 'repository'
default['xlr']['threads'] = '3'
default['xlr']['ssl'] = 'false'
default['xlr']['csre'] = 'true'
default['xlr']['http_bind'] = '0.0.0.0'
default['xlr']['http_context_root'] = '/'
default['xlr']['threads_max'] = '24'
default['xlr']['cstm'] = '0'
default['xlr']['hide_internals'] = 'false'
default['xlr']['import_packages'] = 'importablePackages'
default['xlr']['port'] = '5516'

# ==================================================
# Attributes regarding the downloadable install zip
# ==================================================
default['xlr']['filename'] = "xl-release-#{node['xlr']['version']}-server.zip"
default['xlr']['username'] = '<xebialabs customer username>'
default['xlr']['password'] = '<xebialabs customer password>'
default['xlr']['downloadurl'] = "https://#{node['xlr']['username']}:#{node['xlr']['password']}@dist.xebialabs.com/xl-release/#{node['xlr']['version']}/#{node['xlr']['filename']}"

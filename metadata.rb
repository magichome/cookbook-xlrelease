name 'xlrelease'
version '1.1.0'

maintainer 'Tim Fleming'
maintainer_email 'tim@magichome.net'

description 'Installs and configures XL Release from XebiaLabs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

supports 'centos'

license 'Apache v2.0'

source_url 'https://github.com/magichome/cookbook-xlrelease'
issues_url 'https://github.com/magichome/cookbook-xlrelease/issues'

depends 'runit',  '~> 1.5'
depends 'java',   '~> 1.25'
depends 'tar',    '~> 0.5'

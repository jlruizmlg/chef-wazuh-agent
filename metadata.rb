name             'wazuh'
maintainer       'Wazuh Inc.'
maintainer_email 'support@wazuh.com'
license          'Apache 2.0'
description      'Installs and onfigures Wazuh services'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

%w( apt ).each do |pkg|
  depends pkg
end

%w( debian ubuntu ).each do |os|
  supports os
end

depends 'apt'
depends 'yum'

Wazuh cookbook
==============

Installs wazuh-agent from package in a agent installation. More information in the following link:

[https://documentation.wazuh.com/current/installation-guide/installing-wazuh-agent/index.html](https://documentation.wazuh.com/current/installation-guide/installing-wazuh-agent/index.html)

Requirements
------------
#### Platforms
Tested on Ubuntu and Centos, but should work on any Unix/Linux platform supported by Wazuh. Installation by default is done from source, so the build-essential cookbook needs to be used (see below).

This cookbook doesn't configure Windows systems yet. For information on installing Wazuh on Windows.

#### Chef
- Chef 11+


## Attributes

### default.rb
- `node['wazuh']['dir']` - Installation directory for wazuh-agent, default `/var/ossec`. All existing packages use this directory so you should not change this.
- `node['wazuh']['hostname_server_ip']` - The IP of the wazuh server.
- `node['wazuh']['config-profile']` - In this variable you can setup the different profiles if are needed.
- `node['ossec']['protocol']` - Define the comunication protocol between the manager and agent.
- `node['wazuh']['localfile-command']` - De differents commands running by wazuh-agent in the system.
- `node['wazuh']['localfile']` - De differents logs configuration by wazuh-agent in the system.


### atuhd.rb

- `default['wazuh']['agent_auth']['name'] = node['hostname']` - Agent name by default the hostname name.
- `default['wazuh']['agent_auth']['host'] = node['wazuh']['hostname_server_ip']` - The server where wazuh-agent should ask for the key.
- `default['wazuh']['agent_auth']['port'] = 1515` - The port through agent-authd should connect with wazuh-manager.
- `default['wazuh']['agent_auth']['ca'] = nil` - Full path to the CA certificate used to verify the server if it's needed.
- `default['wazuh']['agent_auth']['certificate'] = nil` - Load the PEM encoded certificate that will be presented to ossec-authd during establishment of the SSL connection if it's needed
- `default['wazuh']['agent_auth']['key'] = nil` - Full path to the agent key if it's needed


#### wazuh-agent default variables
```
default['wazuh']['dir'] = '/var/ossec'
default['wazuh']['hostname_server_ip'] = '192.168.2.35'

default['wazuh']['config-profile'] = 'centos, centos7'

## This protocol need to be according with wazuh-manager configuration.
default['wazuh']['protocol'] = 'udp'


##Some command configuration examples:

default['wazuh']['localfile-command'] = {
    "df -P" => {
      "command" => '360'
    },
    "netstat -tln | grep -v 127.0.0.1 | sort" => {
      "full_command" => '360'
    },
    "full_command" => {
      "command" => '360'
    }
  }

## Some logs configuration examples:

default['wazuh']['localfile'] = {
    "Apache-access" => {
      "syslog" => '/var/log/https/acces.log'
    },
    "Apache-error" => {
      "syslog" => '/var/log/https/error.log'
    }
  }
```

#### agent-auth variables

```

default['wazuh']['agent_auth']['host'] = node['wazuh']['hostname_server_ip']
default['wazuh']['agent_auth']['name'] = node['hostname']
default['wazuh']['agent_auth']['port'] = 1515

default['wazuh']['agent_auth']['ca'] = nil
default['wazuh']['agent_auth']['certificate'] = nil
default['wazuh']['agent_auth']['key'] = nil

```

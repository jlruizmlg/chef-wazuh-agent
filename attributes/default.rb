#
# Cookbook Name:: wazuh
# Attributes:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# general settings
default['wazuh']['dir'] = '/var/ossec'
default['wazuh']['hostname_server_ip'] = '192.168.2.41'

default['wazuh']['config-profile'] = 'centos, centos7'
default['wazuh']['protocol'] = 'udp'


default['wazuh']['system_audit'] = 'cis_rhel7_linux_rcl.txt'

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


default['wazuh']['localfile'] = {
    "Apache-access" => {
      "syslog" => '/var/log/https/acces.log'
    },
    "Apache-error" => {
      "syslog" => '/var/log/https/error.log'
    }
  }

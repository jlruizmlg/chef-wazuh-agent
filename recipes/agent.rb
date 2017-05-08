#
# Cookbook Name:: ossec
# Recipe:: agent_auth
#
# Copyright 2015, Opscode, Inc.
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

include_recipe 'apt::default'

include_recipe 'wazuh::install_agent'

dir = node['wazuh']['dir']
agent_auth = node['wazuh']['agent_auth']

args = "-m #{agent_auth['host']} -p #{agent_auth['port']} -A #{agent_auth['name']}"

if agent_auth['ca'] && File.exist?(agent_auth['ca'])
  args << ' -v ' + agent_auth['ca']
end

if agent_auth['certificate'] && File.exist?(agent_auth['certificate'])
  args << ' -x ' + agent_auth['certificate']
end

if agent_auth['key'] && File.exist?(agent_auth['key'])
  args << ' -k ' + agent_auth['key']
end

execute "#{dir}/bin/agent-auth #{args}" do
  timeout 30
  ignore_failure true
  only_if { agent_auth['host'] && !File.size?("#{dir}/etc/client.keys") }
end

template "#{node['wazuh']['dir']}/etc/ossec.conf" do
  source 'var/ossec/etc/ossec.conf.erb'
  owner 'root'
  group 'ossec'
  action :create
  notifies :restart, "service[wazuh-agent]", :delayed
end

template "#{node['wazuh']['dir']}/etc/local_internal_options.conf" do
  source 'var/ossec/etc/local_internal_options.conf.erb'
  owner 'root'
  group 'ossec'
  action :create
  notifies :restart, "service[wazuh-agent]", :delayed
end

include_recipe 'wazuh::common'

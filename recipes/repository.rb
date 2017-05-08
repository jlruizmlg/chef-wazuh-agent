#
# Cookbook Name:: wazuh
# Recipe:: repository
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

case node['platform']
when "debian", "ubuntu"
  package 'lsb-release'

  ohai 'reload lsb' do
    plugin 'lsb'
    # action :nothing
    subscribes :reload, 'package[lsb-release]', :immediately
  end

  apt_repository 'Wazuh' do
    uri 'https://packages.wazuh.com/apt/'
    key 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    distribution lazy { node['lsb']['codename'] }
    components ['main']
  end
when 'redhat'
  yum_repository 'Wazuh' do
    description 'WAZUH Repository - www.wazuh.com'
    baseurl 'https://packages.wazuh.com/yum/rhel/$releasever/$basearch'
    gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    action :create
  end
when 'centos'
  yum_repository 'Wazuh' do
    description 'WAZUH Repository - www.wazuh.com'
    baseurl 'https://packages.wazuh.com/yum/el/$releasever/$basearch'
    gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    action :create
end
when 'fedora'
  yum_repository 'Wazuh' do
    description 'WAZUH OSSEC Repository - www.wazuh.com'
    baseurl 'https://packages.wazuh.com/yum/fc/$releasever/$basearch'
    gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    action :create
end
end

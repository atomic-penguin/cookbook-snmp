#
# Cookbook Name:: snmp
# Recipe:: default
#
# Copyright 2010, Eric G. Wolfe
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

node['snmp']['packages'].each do |snmppkg|
  package snmppkg
end

template '/etc/default/snmpd' do
  mode 0644
  owner 'root'
  group 'root'
  only_if { node['platform_family'] == 'debian' }
end

service node['snmp']['service'] do
  action [:start, :enable]
end

groupnames = []
node['snmp']['groups']['v1'].each_key { |key| groupnames << key }
node['snmp']['groups']['v2c'].each_key { |key| groupnames << key }
groupnames = groupnames.uniq

template node['snmp']['conffile'] do
  source 'snmpd.conf.erb'
  mode node['snmp']['conf_mode']
  owner node['snmp']['conf_owner']
  group node['snmp']['conf_group']
  variables(groups: groupnames)
  notifies :restart, "service[#{node['snmp']['service']}]"
end

#
# Cookbook Name:: snmp
# Recipe:: snmptrapd
#
# Copyright 2013, Eric G. Wolfe
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

node.set['snmp']['snmpd']['trapd_run'] = 'yes'

include_recipe 'snmp'

service node['snmp']['snmptrapd']['service'] do
  action [:enable, :start]
end

template '/etc/snmp/snmptrapd.conf' do
  mode node['snmp']['config_permissions']
  owner 'root'
  group 'root'
  notifies :restart, "service[#{node['snmp']['snmptrapd']['service']}]"
end

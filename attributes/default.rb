#
# Cookbook Name:: snmp
# Attributes:: default
#
# Copyright 2010, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# family specific config
case node['platform_family']
when 'rhel'
  default['snmp']['packages'] = %w(net-snmp net-snmp-utils)
  default['snmp']['snmpd']['snmpd_opts'] = '-LS0-5d -Lf /dev/null -p /var/run/snmpd.pid'
when 'debian'
  default['snmp']['packages'] = %w(snmp snmpd)
  default['snmp']['snmpd']['snmpd_run'] = 'yes'
  default['snmp']['snmpd']['snmpd_opts'] = '-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid'
  # default['snmp']['snmptrapd']['trapd_run'] = 'no'
  default['snmp']['snmptrapd']['trapd_opts'] = '-Lsd -p /var/run/snmptrapd.pid'
  default['snmp']['snmpd']['snmpd_compat'] = 'yes'
when 'suse'
  default['snmp']['packages'] = %w(net-snmp)
when 'fedora'
  default['snmp']['packages'] = %w(net-snmp net-snmp-utils)
else
  default['snmp']['packages'] = %w(net-snmp net-snmp-utils)
end

# Same on supported platforms:
# redhat, centos, fedora, scientific, debian, ubuntu
default['snmp']['service'] = 'snmpd'

# Global snmp config
default['snmp']['mibdirs'] = '/usr/share/snmp/mibs'
default['snmp']['mibs'] = nil

# snmpd - basis
default['snmp']['snmpd']['conffile'] = '/etc/snmp/snmpd.conf'
default['snmp']['snmpd']['conf_owner'] = 'root'
default['snmp']['snmpd']['conf_group'] = 'root'
default['snmp']['snmpd']['conf_mode'] = '0600'

# snmpd - inside config
default['snmp']['snmpd']['agentAddress'] = 'udp:161'
default['snmp']['snmpd']['agentAddress6'] = 'udp6:161'
default['snmp']['snmpd']['community'] = 'public'
default['snmp']['snmpd']['sec_name'] = { 'notConfigUser' => %w(default) }
default['snmp']['snmpd']['sec_name6'] = { 'notConfigUser' => %w(default) }
default['snmp']['snmpd']['groups']['v1'] = { 'notConfigGroup' => %w(notConfigUser) }
default['snmp']['snmpd']['groups']['v2c'] = { 'notConfigGroup' => %w(notConfigUser) }
default['snmp']['snmpd']['full_systemview'] = false
default['snmp']['snmpd']['additional_oids'] = nil # Might be String or Array of Strings
default['snmp']['snmpd']['syslocationVirtual'] = 'Virtual Server'
default['snmp']['snmpd']['syslocationPhysical'] = 'Server Room'
default['snmp']['snmpd']['syscontact'] = 'Root <root@localhost>'
default['snmp']['snmpd']['sysname'] = node['fqdn']
default['snmp']['snmpd']['pass'] = {}
default['snmp']['snmpd']['pass_persist'] = {}
default['snmp']['snmpd']['process_monitoring']['proc'] = []
default['snmp']['snmpd']['process_monitoring']['procfix'] = []
default['snmp']['snmpd']['include_all_disks'] = false
default['snmp']['snmpd']['all_disk_min'] = 100    # 100K
default['snmp']['snmpd']['disks'] = []
default['snmp']['snmpd']['ignoredisks'] = []
default['snmp']['snmpd']['skipNFSInHostResources'] = nil
default['snmp']['snmpd']['load_average'] = []
default['snmp']['snmpd']['trapsinks'] = []
default['snmp']['snmptrapd']['trapcommunity'] = 'public'
default['snmp']['snmptrapd']['trapd_run'] = 'no'
default['snmp']['snmpd']['extend_scripts'] = {}
default['snmp']['snmpd']['disman_events']['enable'] = false
default['snmp']['snmpd']['disman_events']['user'] = 'disman_events'
default['snmp']['snmpd']['disman_events']['password'] = 'disman_password'
default['snmp']['snmpd']['disman_events']['linkUpDownNotifications'] = 'yes'
default['snmp']['snmpd']['disman_events']['defaultMonitors'] = 'yes'
default['snmp']['snmpd']['disman_events']['monitors'] = []

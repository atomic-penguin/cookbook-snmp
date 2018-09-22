#
# Cookbook Name:: snmp
# Attributes:: snmptrapd
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

# snmptrapd options
default['snmp']['snmptrapd']['service'] = case node['platform_family']
                                          when 'rhel'
                                            'snmptrapd'
                                          else
                                            node['snmp']['service']
                                          end
default['snmp']['snmptrapd']['traphandle'] = 'default /usr/sbin/snmptthandler'
default['snmp']['snmptrapd']['disableAuthorization'] = 'yes'
default['snmp']['snmptrapd']['donotlogtraps'] = 'yes'

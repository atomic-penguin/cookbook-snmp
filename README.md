SNMP
----

[![Chef cookbook](https://img.shields.io/cookbook/v/chef-sugar.svg)](https://github.com/thomasvincent/cookbook-snmp)
[![Build Status](https://travis-ci.org/thomasvincent/cookbook-snmp.svg?branch=master)](https://travis-ci.org/thomasvincent/cookbook-snmp)

Installs and configures snmpd.

### SNMP multiplex

The SNMP multiplex (smuxpeer) line will be set for Dell OpenManage, if Dell
manufactured hardware is detected by Ohai.

### Recipes

* snmp::default
  - Installs and configures SNMPD

* snmp::snmptrapd
  - Configures snmptrapd

### Attributes - snmp - global configuration

* `snmp['snmp']['mibdirs']`
  - MIB directories.  
  - Default: "/usr/share/snmp/mibs".

* `snmp['snmp']['mibs']`
  - MIBs to load.  The default is not to set any and is therefore dependant
     on the daemon default.
  - Default: nil.

### Attributes - snmpd - basis

Notable overridable attributes are as follows.  It is recommended to override
these following attributes to best suit your own environment.

* `snmp['snmpd']['conffile']`
  - ...
  - Default: 

* `snmp['snmpd']['conf_owner']`
  - ...
  - Default: 

* `snmp['snmpd']['conf_group']`
  - ...
  - Default: 

* `snmp['snmpd']['conf_mode']`
  - ...
  - Default: 

### Attributes - snmpd - debian specific configuration

* `snmp['snmpd']['snmpd_run']`
  - snmpd control. "yes" means start daemon)
  - Default: "yes".

* `snmp['snmpd']['snmpd_opts']`
  - snmpd options
  - Default: 

* `snmp['snmpd']['trapd_run']`
  - snmptrapd control (default of "no" means do not start daemon)
    master agentx support must be enabled in snmpd before snmptrapd
    can be run.  See snmpd.conf(5) for how to do this.
  - Default: 

* `snmp['snmpd']['trapd_opts']`
  - snmptrapd options
  - Default: 

* `snmp['snmpd']['snmpd_compat']`
  - Create symlink on Debian legacy location to official RFC path
  - Default: is "yes".

### Attributes - inside snmpd config

* `snmp['snmpd']['agentAddress']`
  - Listen address from snmpd for ipv4
  - Default: "udp:161".

* `snmp['snmpd']['agentAddress6']`
  - Listen address from snmpd for ipv6
  - Default: "udp:161".

* `snmp['snmpd']['community']`
  - SNMP Community String
  - Default: "public".

* `snmp['snmpd']['sec_name']`
  - Hash of security name and IPv4 networks to allow access.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default: { 'notConfigUser' => %w(default) }

* `snmp['snmpd']['sec_name6']`
  - Hash of security name and IPv6 networks to allow access.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default: { 'notConfigUser' => %w(default) }

* `snmp['snmpd']['groups']['v1']`
  - Hash of security groups to map security names into for SNMPv1.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default: { 'notConfigGroup' => %w(notConfigUser) }

* `snmp['snmpd']['groups']['v2c']`
  - Hash of security groups to map security names into for SNMPv2c.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default: { 'notConfigGroup' => %w(notConfigUser) }

* `snmp['snmpd']['full_systemview']`
  - Boolean to include the full systemview.
    This defaults to "false" as many distributions ship this way to speed up
     snmpwalk.  However, if you're running SNMP Network Management System,
     you'll want to override this as "true" on your systems.
  - Default: false.

* `snmp['snmpd']['additional_oids']`
  - String or Array of Strings representing the oid to include in systemview.
    This defaults to "nil". You can add one oid in the of '.1.3.6.1.2.1.2021' or
    an array of oids like ['.1.3.6.1.2.1.2021','.1.3.6.1.4.1.20267.200']
  - Default: nil

* `snmp['snmpd']['syslocationVirtual']`
  - String to set the location for Virtual Machines.
  - Default: "Virtual Server".

* `snmp['snmpd']['syslocationPhysical']`
  - String to set the location for physical systems.
  - Default: "Server Room".

* `snmp['snmpd']['syscontact']`
  - String to set a name, and e-mail address for systems.
  - Default is "Root <root@localhost>"

* `snmp['snmpd']['sysname']`
  - Systems name. For example servername.
  - Default: automatically gathered. Nodes fqdn name. But you can override it if you want.

* `snmp['snmpd']['pass']`
  - Pass-through scripts as { oid => script } pairs.
  - Default: is an empty hash.

* `snmp['snmpd']['pass_persist']`
  - Persistent pass-through scripts as { oid => script } pairs.
  - Default: is an empty hash.

* `snmp['snmpd']['process_monitoring']['proc']`
  - Array of processes to monitor. 
  - Default: This is an empty array by default.

* `snmp['snmpd']['process_monitoring']['procfix']`
  - Array of procfix lines to configure. These are run when a monitored process is in an error state.
  - Default: This is an empty array by default.

* `snmp['snmpd']['include_all_disks']`
  - Boolean to include disk usage checks for all filesystems.
  - Default: false.

* `snmp['snmpd']['all_disk_min']`
  - Number of bytes that should be free on each disk when :include\_all\_disks 
    is 'true.'  Can also be expressed as a string specifying a minimum percent
    e.g. "10%".
  - Default: is 100 (100kB) which is the normal snmpd default.

* `snmp['snmpd']['disks']`
  - Specify individual disks to monitor or, if monitoring all disks, specify 
    different minimums.  If set, the template expects this to be an 
    array of hashes specifying the mount point of the disk to monitor and
    the minimum threshold in the form of {:mount => '/', :min => 100000}.
    As with :all\_disk\_min, :min can also be expressed as a percent.
  - Default: is an empty array.

* `snmp['snmpd']['ignoredisks']`
  -  ...
  - Default: is an empty array.

* `snmp['snmpd']['skipNFSInHostResources']`
  -  ...
  - Default: nil.

* `snmp['snmpd']['load_average']`
  - monitors the load average of the local system, specifying thresholds for the
    1-minute, 5-minute and 15-minute averages.
    If set, the template expects this to be a hash specifying the minimum
    threshold in the form of { :max1 => '12', :max5 => '14', :max15 => '14'}.
    Default is an empty array.

* `snmp['snmpd']['trapsinks']`
  - Array of trapsink hosts, and optionall Community Trap strings.
    This is an empty array by default.
  - Default: 

* `snmp['snmptrapd']['trapcommunity']`
  - SNMP Community Trap String, default is "public".
  - Default: "public".

* `snmp['snmptrapd']['trapd_run']`
  - snmptrapd control (default of "no" means do not start daemon)
    master agentx support must be enabled in snmpd before snmptrapd
    can be run.  See snmpd.conf(5) for how to do this.
  - Default: "no".

* `snmp['extend_scripts']`
  - A hash that specifies extension scripts to the SNMP daemon. If set, the template
    will place these name => value pairs in the "Extend" section of the snmpd.conf file.
    The array must be in the format of { 'foo' => '/path/to/foo -arg', 'bar' => '/path/to/bar' }
  - Default:

* `snmp['disman_events']['enable']`
  - Boolean value for enabling DisMan Event MIB configuration
  - Default is false.

* `snmp['disman_events']['user']` and `snmp['disman_events']['password']`
  - String values for SNMPv3 credentials to set for the DisMan Event MIB
    to work.
  - Default:

* `snmp['disman_events']['linkUpDownNotifications']`
  - String value which must be "yes" or "no" to enable traps for link
    state change notifications.
  - Default: is "yes".

* `snmp['disman_events']['defaultMonitors']`
  - String value which must be "yes" or "no" to enable traps for the
    DisMan Event MIB default checks. See the snmpd.conf manual for details.
  - Default: is "yes".

* `snmp['disman_events']['monitors']`
  - Array of string values for additional 'monitor' config entries.
  - Default: is an empty array.

### Usage

Here is a full example featuring commonly overrided attributes.
You can apply these override attributes in a role, or node context.

```
  override_attributes "snmp" => {
    "community" => "secret",
    "full_systemview" => true,
    "disks" => [{:mount => "/", :min => "10%"}],
    "load_average" => {:max1 => "24", :max5 => "12", :max15 => "6" },
    "trapsinks" => [ "zenoss.example.com", "nagios.example.com" ],
    "syslocationPhysical" => "Server Room",
    "syslocationVirtual" => "Cloud - Virtual Pool",
    "syscontact" => "sysadmin@example.com"
  }
```

```
{
  "name": "module_snmp",
  "description": "Baseline role applied to all servers in local network",
  "override_attributes": {
    "snmp": {
      "snmpd": {
        "community": "MYSECRET",
        "full_systemview": true,
        "group": "v2c",
        "snmpd_opts": "-LS0-5d -Lf /dev/null -p /var/run/snmpd.pid",
        "sec_name": {
            "notConfigUser": [ ],
            "SECNAME_SOME": [
              "192.168.99.88"
            ]
        },
        "sec_name6": {
          "notConfigUser": [ ]
        },
        "groups": {
          "v1": {
            "notConfigGroup" : [ ]
          },
          "v2c": {
            "notConfigGroup" : [ ],
            "GROUP_SOME": [
              "SECNAME_SOME"
            ]
          }
        },
        "ignoredisks": [
          "/media/trash"
        ],
        "skipNFSInHostResources": true,
        "include_all_disks": true,
        "all_disk_min": "10%"
      }
    }
  },
  "run_list": [
    "recipe[snmp]"
  ]
}
```


### Author and License

Author:: Eric G. Wolfe (eric.wolfe@gmail.com) [![endorse](https://api.coderwall.com/atomic-penguin/endorsecount.png)](https://coderwall.com/atomic-penguin)
Author:: Thomas Vincent (thomasvincent@gmail.com) [![endorse](https://api.coderwall.com/thomasvincent/endorsecount.png)](https://coderwall.com/thomasvincent)
Author:: Florian Asche (git@florian-asche.de)


Copyright Thomas Vincent 2017
Copyright Eric G. Wolfe 2010-2017

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

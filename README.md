SNMP
----

[![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-snmp.png?branch=master)](http://travis-ci.org/atomic-penguin/cookbook-snmp)

Description
===========

Installs and configures snmpd.

The SNMP multiplex (smuxpeer) line will be set for Dell OpenManage, if Dell
manufactured hardware is detected by Ohai.

### Recipes

* snmp::default
  - Installs and configures SNMP

* snmp::snmptrapd
  - Configures snmptrapd

### Attributes

Notable overridable attributes are as follows.  It is recommended to override
these following attributes to best suit your own environment.

* `snmp['agentAddress']`
  - SNMP Listening address, default is UDP port 161 on all interfaces. See `man 8 snmpd`,
    section LISTENING ADDRESSES for further details.

* `snmp['community']`
  - SNMP Community String, default is "public".

* `snmp['sec_name']`
  - Hash of security name and IPv4 networks to allow access.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default { notConfigUser: ['default'] }

* `snmp['sec_name6']`
  - Hash of security name and IPv6 networks to allow access.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default { notConfigUser: ['default'] }

* `snmp['groups']['v1']`
  - Hash of security groups to map security names into for SNMPv1.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default { notConfigGroup: ['notConfigUser'] }

* `snmp['groups']['v2c']`
  - Hash of security groups to map security names into for SNMPv2c.  See `man 5 snmpd.conf`,
    section VACM Configuration for further details.
  - Default { notConfigGroup: ['notConfigUser'] }

* `snmp['trapcommunity']`
  - SNMP Community Trap String, default is "public".

* `snmp['trapsinks']`
  - Array of trapsink hosts, and optionall Community Trap strings.
    This is an empty array by default.

* `snmp['syscontact']`
  - String to set a name, and e-mail address for systems.
    Default is "Root <root@localhost>"

* `snmp['syslocationPhysical']`
  - String to set the location for physical systems.
    Default is "Server Room".

* `snmp['syslocationVirtual']`
  - String to set the location for Virtual Machines.
    Default is "Virtual Server".

* `snmp['full_systemview']`
  - Boolean to include the full systemview.
    This defaults to "false" as many distributions ship this way to speed up
     snmpwalk.  However, if you're running SNMP Network Management System,
     you'll want to override this as "true" on your systems.

* `snmp['include_all_disks']`
  - Boolean to include disk usage checks for all filesystems.
    Default is "false"

* `snmp['all_disk_min']`
  - Number of bytes that should be free on each disk when :include\_all\_disks 
    is 'true.'  Can also be expressed as a string specifying a minimum percent
    e.g. "10%".
    Default is 100 (100kB) which is the normal snmpd default.

* `snmp['disks']`
  - Specify individual disks to monitor or, if monitoring all disks, specify 
    different minimums.  If set, the template expects this to be an 
    array of hashes specifying the mount point of the disk to monitor and
    the minimum threshold in the form of {:mount => '/', :min => 100000}.
    As with :all\_disk\_min, :min can also be expressed as a percent.
    Default is an empty array.

* `snmp['load_average']`
  - monitors the load average of the local system, specifying thresholds for the
    1-minute, 5-minute and 15-minute averages.
    If set, the template expects this to be a hash specifying the minimum
    threshold in the form of { :max1 => '12', :max5 => '14', :max15 => '14'}.
    Default is nil

* `snmp['extend_scripts']`
  - A hash that specifies extension scripts to the SNMP daemon. If set, the template
    will place these name => value pairs in the "Extend" section of the snmpd.conf file.
    The array must be in the format of { 'foo' => '/path/to/foo -arg', 'bar' => '/path/to/bar' }

* `snmp['snmpd']['mibdirs']`
  - MIB directories.  "/usr/share/snmp/mibs" is the default

* `snmp['snmpd']['mibs']`
  - MIBs to load.  The default is not to set any and is therefore dependant
     on the daemon default.

* `snmp['snmpd']['snmpd_run']`
  - snmpd control (default of "yes" means start daemon)

* `snmp['snmpd']['snmpd_opts']`
  - snmpd options

* `snmp['process_monitoring']['proc']`
  - Array of processes to monitor. This is an empty array by default.

* `snmp['process_monitoring']['procfix']`
  - Array of procfix lines to configure. This is an empty array by default.
  - These are run when a monitored process is in an error state.

* `snmp['snmpd']['trapd_run']`
  - snmptrapd control (default of "no" means do not start daemon)
    master agentx support must be enabled in snmpd before snmptrapd
    can be run.  See snmpd.conf(5) for how to do this.

* `snmp['snmpd']['trapd_opts']`
  - snmptrapd options

* `snmp['snmpd']['snmpd_compat']`
  - Create symlink on Debian legacy location to official RFC path
    Default is "yes".

* `snmp['disman_events']['enable']`
  - Boolean value for enabling DisMan Event MIB configuration
    Default is false.

* `snmp['disman_events']['user']` and `snmp['disman_events']['password']`
  - String values for SNMPv3 credentials to set for the DisMan Event MIB
    to work.

* `snmp['disman_events']['linkUpDownNotifications']`
  - String value which must be "yes" or "no" to enable traps for link
    state change notifications.
    Default is "yes".

* `snmp['disman_events']['defaultMonitors']`
  - String value which must be "yes" or "no" to enable traps for the
    DisMan Event MIB default checks. See the snmpd.conf manual for details.
    Default is "yes".

* `snmp['disman_events']['monitors']`
  - Array of string values for additional 'monitor' config entries.
    Default is an empty array.

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

### Author and License

Author:: Eric G. Wolfe (eric.wolfe@gmail.com) [![endorse](https://api.coderwall.com/atomic-penguin/endorsecount.png)](https://coderwall.com/atomic-penguin)

Copyright 2010-2014

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

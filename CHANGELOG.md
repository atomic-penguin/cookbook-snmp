snmp cookbook CHANGELOG
=======================

v2.0.0
------

  @MrMMorris
  * Add load average checks.

Breaking changes:

  @themoore
  * Remove hardcoded extend scripts and is_dnsserver boolean.
  * Remove perl dependency.
  * Added extend_scripts hash for greater flexibility. #21

v1.1.0
------

  @slashterix
  * Use default level over set #9

  @odyssey4me contributed:
  * Array `snmp['snmpd']['mibs']` to specify list of MIBs to load #12
  * Arrays `snmp['process_monitory']['proc']` and `snmp['process_monitoring']['procfix']
    for monitoring process table and corrective procfix commands. #13
  * Attributes `snmp['disman_events']` for SNMP Distributed Management #14

  @sfiggins contributed:
  * Attributes `snmp['include_all_disks']` (bool),
    `snmp['all_disk_min']` (String for minimum kilobytes/percent free),
    and `snmp['disks']` (Hash of mount points and/or minimum thresholds). #17

  * Corrected rubocop warnings.
  * Add chefspec/Remove minitest
  * Add basic BATS tests
  * Add erubis check for templates

v1.0.0
------
  
  Add snmptrapd recipe, and add RHEL support.
  Template debian files.
  Add test-kitchen skeleton.
  Typos in platform_family case switches.
  Check for existence of dmi OHAI attribute, before checking in a condition.
  Correct minitest-spec file for Chef 11.x  

v0.4.0
------

  Add necessary setup for the HP System Management Homepage to be able to poll via @tas50
  Add Suse support via @jackl0phty
  FC043: Prefer new notification syntax: ./recipes/default.rb:38

v0.3.1
------

Fix Gemfile for Travis.

Foodcritic warnings resolved

* FC007: Ensure recipe dependencies are reflected in cookbook metadata

v0.3.0
------

Merge pull request #1 from gustavowt/master

* Ubuntu package name fixes

Add [test-kitchen](https://github.com/opscode/test-kitchen) scaffolding

* Simple snmp::default test

Add TravisCI attribute sanity tests, and foodcritic linting.

Foodcritic warnings resolved

* FC001: Use strings in preference to symbols to access node attributes
* FC024: Consider adding platform equivalents

v0.2.0
------

Refactor SNMP cookbook

v0.1.0
------

* Add Getopt::Declare dependency
* Update metadata
* Update documentation

v0.0.1
------

Add snmp cookbook.

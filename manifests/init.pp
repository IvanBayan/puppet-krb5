# Class: krb5
#
# This module manages krb5
#
# Parameters:
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: true
#
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file_static*]
#		Copy configuration file from specifyed location
#		Default: undef
#
# Actions:
#  Install krb5 librarys and allow configure krb5.conf
#
# Requires:
# concat - https://github.com/ripienaar/puppet-concat
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class krb5 (
	$autoupgrade = true,
	$ensure = 'present',
	$package = $krb5::params::package,
	$config_file = $krb5::params::config_file,
	$config_file_replace = true,
	$config_file_static = undef
) inherits krb5::params {
	
	case $ensure {
		/(present)/: {
			if $autoupgrade == true {
				$package_ensure = 'latest'
			} else {
				$package_ensure = 'present'
			}
		}
		/(absent)/: {
			$package_ensure = 'absent'
		}
		default: {
			fail('ensure parameter must be present or absent')
		}
	}
	
	package { $package:
		ensure => $package_ensure,
	}

	if( $config_file_static != undef ) {
		file{ $config_file:
			ensure => $ensure,
			owner => root,
			group => root,
			mode => 0644,
			content => 'puppet:///modules/krb5/krb5.conf',
		}
	} else {
		#include krb5::config
	} 
}

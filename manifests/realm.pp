define krb5::realm(
	$config_file = $krb5::config_file,
	$default_domain='',
	$kpasswd_server='',
	$kpasswd_protocol='',
	$admin_server='',
	$kdc,$v4_name_convert={}
) {
	include krb5::config
	$realm = $name
    concat::fragment{"domain_$realm":
    	target  => $config_file,
    	order   => '03',
    	content => template('krb5/krb5domain.conf.erb')
	}
	
	concat::fragment{"realm_$realm":
		target  => $config_file,
		order   => '05',
		content => template('krb5/krb5realm.conf.erb')
	}
}

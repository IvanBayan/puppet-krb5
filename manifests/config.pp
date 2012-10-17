class krb5::config (
	$krb5default			= '',
	$krb5ticket_lifetime	= '25h',
	$krb5renew_lifetime		= '120h',
	$krb5forwardable		= 'true',
	$krb5proxiable			= 'true',
	$krb5enctype			= ['arcfour-hmac-md5','aes256-cts','aes128-cts','des3-cbc-sha1','des-cbc-md5','des-cbc-crc'],
	$krb5pam				= {	'external'         => 'true',
								'krb4_convert'     => 'false',
								'krb4_convert_524' => 'false',
								'krb4_use_as_req'  => 'false'
							},
        $krb5kinit = {
            'renewable'   => 'true',
            'forwardable' => 'true',
        },
	$config_file = $krb5::config_file,
  $krb5udppreferencelimit = undef,
  $krb5dnslookuprealm = undef,
  $krb5dnslookupkdc = undef,
  $krb5allowweakcrypto = undef
) {
  
	if $krb5::config_file_static != undef {
		fail( '$krb5::config_file_static defined, you can not use dynamic config generation if use static config' )
	}
	
	include concat::setup
	Class[ 'krb5::config' ] -> Class[ 'krb5' ]
	
	concat { $config_file:
		owner	=> 'root',
		group	=> 'root',
		mode	=> 0644
	}
	
	concat::fragment { 'krb5_header':
		target  => $config_file,
		order   => '01',
		content => template('krb5/krb5.conf.erb')
	}
	
	concat::fragment{'krb5_domain_header':
		target  => $config_file,
		order   => '02',
		content => "[domain_realm]\n"
	}
	
	concat::fragment{'krb5_realms_header':
		target  => $config_file,
		order   => '04',
		content => "\n[realms]\n"
  }
	
}

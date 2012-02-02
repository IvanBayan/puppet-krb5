class{ 'krb5':
	config_file	=> '/tmp/krb5.conf',
	package		=> [ 'libkrb53', 'krb5-user' ]
}

class{ 'krb5::config':
	krb5default => 'TEST.RU',
	krb5ticket_lifetime => '25h',
	krb5renew_lifetime  => '120h',
	krb5forwardable     => 'true',
	krb5proxiable       => 'true',
	krb5enctype         => ['arcfour-hmac-md5','aes256-cts','aes128-cts','des3-cbc-sha1','des-cbc-md5','des-cbc-crc'],
	krb5pam             => {'external'         => 'true',
                          'krb4_convert'     => 'false',
                          'krb4_convert_524' => 'false',
                          'krb4_use_as_req'  => 'false'
                         }
	
}

krb5::realm{ 'TEST.RU':
	default_domain  => 'test.ru',
	kdc             => [ 'dc1.test.ru:88', 'dc2.test.ru:88' ],
	kpasswd_server  => 'kpass.test.ru',
	admin_server    => 'kadmin.test.ru',
	v4_name_convert => { 'host' => { 'rcmd' => 'host' }  }
}
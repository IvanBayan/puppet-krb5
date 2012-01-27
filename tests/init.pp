

class{ 'krb5':
	config_file => "/tmp/krb5.conf"
}
class{ 'krb5::config':
	krb5default => 'MERANN.RU'
}

krb5::realm{ 'MERANN.RU':
	default_domain  => 'merann.ru',
	kdc             => ['dc1.mera.ru:88', 'dc1.merann.ru:88'],	
}

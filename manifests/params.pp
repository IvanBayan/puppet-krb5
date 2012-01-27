class krb5::params {
  case $::operatingsystem {
    /(Debian)/: {
    	if $::lsbmajdistrelease == 6 {
    		$package = 'libkrb53'
    	}      
      $config_file = '/etc/krb5.conf'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem} or version ${::lsbmajdistrelease}, look at manifests/params.pp")
    }
  }
}

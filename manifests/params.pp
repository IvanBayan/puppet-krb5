class krb5::params {
  case $::operatingsystem {
    /(Debian)/: {
    	if $::lsbmajdistrelease == 6 {
    		$package = 'libkrb53'
    	}      
      $config_file = '/etc/krb5.conf'
    }
    /(CentOS)/: {
        # Can't test against $::lsbmajdistrelease due to
        # http://projects.puppetlabs.com/issues/15159
        $package = [ 'krb5-libs', 
                     'krb5-workstation',
                     'krb5-auth-dialog', 
                     'pam_krb5' ]
        $config_file = '/etc/krb5.conf'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem} or version ${::lsbmajdistrelease}, look at manifests/params.pp")
    }
  }
}

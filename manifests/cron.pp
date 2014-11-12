# cron.pp

class system::cron (

	$package_manage = false,
	$package_ensure = latest,
	$package_name = 'cron',

	$service_manage = true,
	$service_enable = true,
	$service_ensure = running,
	$service_name = 'cron',

	$configdir = '/etc',

	$cronallow = ['root'],
	$crondeny = [],

	$cronallowtemplate = 'system/etc/cron.allow.erb',
	$crondenytemplate = 'system/etc/cron.deny.erb',

) {

	validate_bool($package_manage)
	validate_string($package_ensure)
	validate_string($package_name)

	validate_bool($service_manage)
	validate_bool($service_enable)
	validate_string($service_ensure)
	validate_string($service_name)

	validate_absolute_path($configdir)

	validate_array($cronallow)
	validate_array($crondeny)
	validate_string($cronallowtemplate)
	validate_string($crondenytemplate)

	if $package_manage == true {

		package { $package_name:

			ensure => $package_ensure,
		}
	}

	$config_ensure = $package_ensure ? {

		'absent' => 'absent',
		'purged' => 'absent',
		default => present,
	}

	file { "${configdir}/cron.allow":

		ensure => $config_ensure,
		mode => '0644',
		owner => 'root',
		group => 'root',
		content => template($cronallowtemplate),
	}->
	file { "${configdir}/cron.deny":

		ensure => $config_ensure,
		mode => '0644',
		owner => 'root',
		group => 'root',
		content => template($crondenytemplate),
	}

	if !($service_ensure in [ 'running', 'stopped' ]) {

		fail('service_ensure parameter must be running or stopped')
	}

	if $service_manage == true {

		service { $service_name:

			enable => $service_enable,
			ensure => $service_ensure,
		}
	}
}
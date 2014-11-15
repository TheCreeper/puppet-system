# cron.pp

class system::cron (

	$package_manage = false,
	$package_ensure = latest,
	$package_name = 'cron',

	$service_manage = false,
	$service_enable = true,
	$service_ensure = running,
	$service_name = 'cron',

	$config_dir = '/etc',
	$config_ensure = present,
	$config_mode = 0644,
	$config_owner = 'root',
	$config_group = 'root',

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

	validate_absolute_path($config_dir)
	validate_string($config_ensure)
	validate_string($config_mode)
	validate_string($config_group)

	validate_array($cronallow)
	validate_array($crondeny)
	validate_string($cronallowtemplate)
	validate_string($crondenytemplate)

	if $package_manage == true {

		package { $package_name:

			ensure => $package_ensure,
		}
	}

	$cfg_ensure = $package_ensure ? {

		'absent' => 'absent',
		'purged' => 'absent',
		default => $config_ensure,
	}

	file { "${config_dir}/cron.allow":

		ensure => $cfg_ensure,
		mode => $config_mode,
		owner => $config_owner,
		group => $config_group,
		content => template($cronallowtemplate),
	}->
	file { "${config_dir}/cron.deny":

		ensure => $cfg_ensure,
		mode => $config_mode,
		owner => $config_owner,
		group => $config_group,
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
# login.pp

class system::login (

	$package_manage = false,
	$package_ensure = latest,
	$package_name = 'login',

	$config_path = '/etc/login.defs',
	$config_ensure = present,
	$config_mode = 0644,
	$config_owner = 'root',
	$config_group = 'root',
	$config_template = 'system/etc/login.defs.erb',

	$mail_dir = '/var/mail',
	$mail_file = undef,
	$faillog_enab = 'yes',
	$log_unkfail_enab = 'no',
	$log_ok_logins = 'no',
	$syslog_su_enab = 'yes',
	$syslog_sg_enab = 'yes',
	$sulog_file = undef,
	$ttytype_file = undef,
	$ftmp_file = '/var/log/btmp',
	$su_name = 'su',
	$hushlogin_file = '.hushlogin',

	$env_supath = 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
	$env_path = 'PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games',

	$ttygroup = 'tty',
	$ttyperm = '0600',

	$erasechar = '0177',
	$killchar = '025',
	$umask = 066,

	$pass_max_days = '99999',
	$pass_min_days = '0',
	$pass_warn_age = '7',

	$uid_min = '1000',
	$uid_max = '60000',
	$sys_uid_min = '100',
	$sys_uid_max = '999',

	$gid_min = '1000',
	$gid_max = '60000',
	$sys_gid_min = '100',
	$sys_gid_max = '999',

	$login_retries = '5',
	$login_timeout = '60',

	$chfn_restrict = 'rwh',
	$default_home = 'yes',
	$userdel_cmd = undef,
	$usergroups_enab = 'yes',
	$fake_shell = undef,
	$console = undef,
	$console_groups = undef,

	$md5_crypt_enab = undef,
	$encrypt_method = undef,
	$sha_crypt_min_rounds = undef,
	$sha_crypt_max_rounds = undef,

) {

	validate_absolute_path($config_path)
	validate_string($config_ensure)
	validate_string($config_mode)
	validate_string($config_group)
	validate_string($config_template)

	validate_string($mail_dir)
	validate_string($mail_file)
	validate_string($faillog_enab)
	validate_string($log_unkfail_enab)
	validate_string($log_ok_logins)
	validate_string($syslog_su_enab)
	validate_string($syslog_sg_enab)
	validate_string($sulog_file)
	validate_string($ttytype_file)
	validate_string($ftmp_file)
	validate_string($su_name)
	validate_string($hushlogin_file)

	validate_string($env_supath)
	validate_string($env_path)

	validate_string($ttygroup)
	validate_string($ttyperm)

	validate_string($erasechar)
	validate_string($killchar)
	validate_string($umask)

	validate_string($pass_max_days)
	validate_string($pass_min_days)
	validate_string($pass_warn_age)

	validate_string($uid_min)
	validate_string($uid_max)
	validate_string($sys_uid_min)
	validate_string($sys_uid_max)

	validate_string($gid_min)
	validate_string($gid_max)
	validate_string($sys_gid_min)
	validate_string($sys_gid_max)

	validate_string($chfn_restrict)
	validate_string($default_home)
	validate_string($userdel_cmd)
	validate_string($usergroups_enab)
	validate_string($fake_shell)
	validate_string($console)
	validate_string($console_groups)

	validate_string($encrypt_method)
	validate_string($sha_crypt_min_rounds)
	validate_string($sha_crypt_max_rounds)

	if $package_manage == true {

		package { $package_name:

			ensure => $package_ensure,
		}
	}

	file { $config_path:

		ensure => $config_ensure,
		mode => $config_mode,
		owner => $config_owner,
		group => $config_group,
		content => template($config_template),
	}
}
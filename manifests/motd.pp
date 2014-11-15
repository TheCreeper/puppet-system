# motd.pp

class system::motd (

	$config_path = '/etc/motd',
	$config_ensure = present,
	$config_mode = 0644,
	$config_owner = 'root',
	$config_group = 'root',

	$config_template = 'system/etc/motd.erb',
	$config_content = undef,

	$config_header = undef,
	$config_footer = undef,
) {

	validate_absolute_path($config_path)
	validate_string($config_ensure)
	validate_string($config_mode)
	validate_string($config_group)

	validate_string($config_template)
	validate_string($config_content)

	validate_string($config_header)
	validate_string($config_footer)

	if ($config_template) and ($config_content) {

		warning('Both $config_template and $config_content are set. $config_template will be ignored')
		$content = $config_content
	}
	elsif ($config_template) {

		$content = template($config_template)
	}
	else {

		$content = $config_content
	}

	file { $config_path:

		ensure => $config_ensure,
		mode => $config_mode,
		owner => $config_owner,
		group => $config_group,
		content => $content,
	}
}
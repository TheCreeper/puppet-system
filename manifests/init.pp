# init.pp

class system {

	class { 'system::motd': }->
	class { 'system::issue': }->
	class { 'system::login': }->
	class { 'system::cron': }
}
# init.pp

class system {

	class { 'system::login': }->
	class { 'system::cron': }
}
#Instalar mysql

class mysql {

	exec { 'mysql-install':
		command => 'apt-get install mysql-server',
		user => 'ubuntu',
		environment => 'HOME=/home/ubuntu',
		require => Package['curl']
	}
  
}

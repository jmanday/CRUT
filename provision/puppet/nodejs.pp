#Instalar nvm y node

class nodejs {

	exec { 'nvm-install':
		command => '/usr/bin/curl https://raw.github.com/creationix/nvm/master/install.sh | /bin/sh',
		creates => '/home/ubuntu/.nvm',
		user => 'ubuntu',
		environment => 'HOME=/home/ubuntu',
		require => Package['curl']
	}

	exec { 'node-install':
		command => '/bin/bash -c "source /home/ubuntu/.nvm/nvm.sh && nvm install 0.10.23 && nvm alias default 0.10.23"',
		user => 'ubuntu',
		environment => 'HOME=/home/ubuntu',
		require => Exec['nvm-install']
	}
}
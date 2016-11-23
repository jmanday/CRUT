#Crear nuevo usuario

user { 'usuario':
  ensure  => 'present',
  password => '$1$2oW09qoG$Npfy2oYEwO0WQAv33k3TN1/', #Clave generada con openssl
  comment => ‘Creación de nuevo usuario’,
  gid     => '100',
  groups  => ['sudo', 'audio', 'src', 'video'],
  home    => '/home/usuario',
  shell   => '/bin/bash',
  uid     => '1002',
  managehome => yes,
}

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
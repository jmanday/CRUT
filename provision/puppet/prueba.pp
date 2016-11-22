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

class { 'nvm':
  user => ‘usuario’,
  nvm_dir => '/opt/nvm',
  version => 'v0.32.1’,
  profile_path => '/etc/profile.d/nvm.sh',
  install_node => ‘6.9.1’,
}

#Instalar ppm

package { 'forever':
  ensure   => 'present',
  provider => 'npm',
}

#Instalar supervisor

package{ 'supervisor':
  ensure=>'present',
}
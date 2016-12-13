# HITO 3 - ORQUESTACIÓN DE MÁQUINAS VIRTUALES

## Introducción
Para la realización de este hito se va a proceder a orquestar varias máquinas virtuales tanto en modo local como en cloud a través de [Vagrant](https://www.vagrantup.com/).

Lo primero en realizar es instalar **Vagrant** en la máquina local para poder trabajar con la herramienta como se muestra en la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img1.png)

## Orquestación en local
Esta primera orquestación se va a realizar en local, por lo que se instalará [VirtualBox](https://www.virtualbox.org/) como proveedor y se podrá comprobar a través del mismo si **Vagrant** ha creado correctamente las tres máquinas virtuales.

Una vez que se ha instalado la herramienta lo siguiente es definir el fichero **Vagrantfile** mediante el cual se definirán las máquinas virtuales. Para este caso se orquestarán tres máquinas virtuales con diferentes sistemas operativos; una con **Centos** y las dos restantes con **Ubuntu**, una de ellas con la versión **Trusty** de 64 bits, y la otra con la versión **Precise** de 32 bits.

Lo primero será generar un fichero Vagrantfile por defecto con una serie de parámetros que serán posteriormente modificados y adaptados a las máquinas a crear a través de la orden **Vagrant init**, mediante el cual creará el siguiente fichero:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img3.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img4.png)

El fichero será modificado para crear las tres máquinas virtuales mencionadas anteriormente, cada una de ellas tendrán una ip privada además de su respectivo nombre y un provisionamiento que lo realizará **Vagrant** al crearlas a través de los scripts definidos para ello. El fichero tendrá el siguiente aspecto:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img5.png)

Una vez definido el fichero, ejecutamos la orden **Vagrant up** para que levante las tres máquinas virtuales declaradas en el Vagrantfile como muestra la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img6.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img7.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img8.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img9.png)

Otra opción para crear las máquinas virtuales es mediante el proveedor, en este caso como se ha dicho antes **VirtualBox**. Para ello hay que indicarle a la orden de antes el parámetro del proveedor como se puede ver en la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img14.png)

Para comprobar el correcto funcionamiento vamos a mirar en virtualbox si las tres máquinas virtuales han sido creadas:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img10.png)

Además de la anterior comprobación, vamos a realziar una conexión vía ssh con cada una de las máquinas virtuales para confirmar que todo esta correcto.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img11.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img12.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img13.png)

Como muestran las imágenes, la orquestación de las máquinas virtuales en local se ha realizado correctamente.


## Orquestación en cloud
Para realizar la orquestación de varias máquinas virtuales en cloud se va a utilizar el Iaas de [Microsoft Azure](https://azure.microsoft.com/es-es/), aprovechando el la subscripción gratis que regalan durante un mes.

Se definirán dos máquinas virtuales con Ubuntu de 64 bits, una de ellas será provisionada con [MySQL](https://www.mysql.com/) y la otra con [Node](https://nodejs.org/es/).

Lo primero que haremos será instalar el plugin de **azure** a **Vagrant** mediante el siguiente comando:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img15.png)

Una vez que se ha instalado el plugin correspondiente de manera exitosa, lo siguiente será definir los ficheros Vagranfile para las máquinas virtuales. Se definirá un fichero por cada máquina ya que cada uno de ellos llevará asociado su fichero de ansible para el respectivo provisionamiento.

Antes de comenzar a definir los ficheros de **Vagrant** es necesario añadir la "caja" (**box**) base a partir de la cual se crearán las dos máquinas virtuales:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img15.png)

Con la imagen base ya añadida al vagrant pasamos a definir los ficheros **Vagrantfile** para cada una de las máquinas virtuales que aunque serán muy parecidos y compartiran los mismos recursos a nivel de certificados de seguridad para la conexión con la máquina local, se distinguen en algunos parámetros.

Para la primera máquina se ha definido el siguiente Vagrantfile:

	VAGRANTFILE_API_VERSION = '2'

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  		config.vm.box     = 'azure'
  		config.vm.box_url = 'https://github.com/msopentech/	vagrant-azure/raw/master/dummy.box'

  		config.ssh.username         = 'vagrant'

  		config.vm.provider :azure do |azure|
  			#full path to pem file
			azure.mgmt_certificate = File.expand_path('~/.ssh/azurevagrant.key')
    		azure.mgmt_endpoint = 'https://management.core.windows.net'
    
    		#to get this run: azure account list
    		azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

			azure.storage_acct_name = '' # optional
	
			#to get this run: azure vm image list	
			azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
    
    		azure.vm_user = 'vagrant' # defaults to 'vagrant' if not provided
    		azure.vm_password = 'vagrant123#@!' # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

			azure.vm_name = 'azurevagrant-mysql' # max 15 characters. contains letters, number and hyphens. can start with letters and can end with letters and numbers
    		azure.cloud_service_name = '' # same as vm_name. leave blank to auto-generate

    		##to get this run: azure vm location list
    		azure.vm_location = 'North Europe'

    		azure.tcp_endpoints = '3389:53389' # opens the Remote Desktop internal port that listens on public port 53389. Without this, you cannot RDP to a Windows VM.
    		azure.winrm_https_port = 5986
			azure.ssh_port = '22'
	
    		azure.winrm_transport = %w(https)
  		end
  
  		config.vm.provision "ansible" do |ansible|
    		ansible.playbook = "playbook-MySQL.yml"
  		end
  
	end
	
Entre algunos de los parámetros de la configuración se encuentra el **Identificador de la subscripción** de azure, la **localización** de la máqina, el puerto ssh, el certificado, etc.

En la última instrucción del fichero es donde se pasa a la parte del provisionamiento con **Ansible** usando para ello el siguiente dichero yml definido para esta instancia:

	- hosts: azurevagrant-mysql
  	  become: yes
  	  remote_user: vagrant
 
  	  tasks:
    	  - name: Actualizar paquetes
      	 	 apt: pkg=aptitude state=present
    	  - name: Instalar MySQL
      		 apt: name={{ item }} update_cache=yes cache_valid_time=3600 state=present
      		 with_items:
        		- python-mysqldb
        		- mysql-server
    	  - name: Ejecutar el servicio MySQL 
      		 service: 
        		name: mysql 
        		state: started
        		enabled: true

Por último queda ejecutar la orden **Vagrant up --provider=azure** para comenzar con la creación de la máquina virtual en la infraestructura de **Microsoft** como se muestra en la imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img17.png)


Finalizado el proceso pasamos a comprobar que todo se ha realizado correctamente mediante una conexión por medio de ssh a la máquina.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img18.png)


Como muestra la anterior imagen anterior la creación de la máquina virtual para **MySQL** y su provisionamiento se han realizado correctamente.

Ahora toca hacer lo mismo pero con el fichero **Vagrantfile** definido para la máquina virtual con **node** con su fichero de provionamiento correspondiente para esas dependencias.

	VAGRANTFILE_API_VERSION = '2'

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  		config.vm.box     = 'azure'
  		config.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

  		config.ssh.username         = 'vagrant'
  
  		config.vm.provider :azure do |azure|
  			#full path to pem file
			azure.mgmt_certificate = File.expand_path('~/.ssh/azurevagrant.key')
    		azure.mgmt_endpoint = 'https://management.core.windows.net'
    
    		#to get this run: azure account list
    		azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

			azure.storage_acct_name = '' # optional
	
			#to get this run: azure vm image list	
			azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
    
    		azure.vm_user = 'vagrant' # defaults to 'vagrant' if not provided
    		azure.vm_password = 'vagrant123#@!' # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

			azure.vm_name = 'azurevagrant-node' # max 15 characters. contains letters, number and hyphens. can start with letters and can end with letters and numbers
    		azure.cloud_service_name = '' # same as vm_name. leave blank to auto-generate

    		##to get this run: azure vm location list
    		azure.vm_location = 'North Europe'

    		azure.tcp_endpoints = '3389:53389' # opens the Remote Desktop internal port that listens on public port 53389. Without this, you cannot RDP to a Windows VM.
    		azure.winrm_https_port = 5986
			azure.ssh_port = '22'
	
    		azure.winrm_transport = %w(https)
  		end
  
  		config.vm.provision "ansible" do |ansible|
    		ansible.playbook = "playbook-Node.yml"
  		end
	end
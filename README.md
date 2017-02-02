#CRUT


##Descripción del problema

En el ámbito de la industria 4.0 son muchos los sistemas que continúan anclados a un entorno de ejecución que les impiden escalar y mejorar su propio rendimiento.

Son muchos los dispositivos, tecnologías, protocolos y software empleados en el desarrollo de un sistema de control industrial. Una de las principales funciones que se desarrollan en este ámbito esta orientada a la configuración de los dispositivos de control, los cuales necesitan de unos parámetros e información necesaria para poder realizar su cometido.



##Solución propuesta

CRUT (Cloud RTU Universal Tool) nace de la necesidad que hasta el momento el mundo de la industria ha vivido en el marco de la configuración sobre dispositivos de carácter programables como PLCs, RTUs, etc, encargados de controlar el correcto comportamiento de procesos industriales.

Hasta el momento, la parametrización de un dispositivo programable; en este caso particular una RTU, se realiza a través de un software de escritorio el cual debe estar físicamente conectado al dispositivo para poder enviarle los datos de configuración. Este trabajo resulta tedioso ya que la persona responsable de dicha tarea tiene que desplazarse personalmente a la localización donde se encuentren los dispositivos para poder configurarlos.

La herramienta CRUT agiliza todo ese proceso, ya que de este modo no es necesario conectarse físicamente al dispositivo para parametrizarlo. CRUT ofrece una plataforma de configuración remota desde la que es posible realizar dicha tarea en cualquier dispositivo desde cualquier situación con conexión a internet.

CRUT elimina las barreras existentes hasta ahora y agiliza las operaciones de configuración, haciendolas mas ligeras y expandibles.



##Arquitecura software

Se han estudiado los diferentes tipos de arquitecturas software para evaluar a cual de ellas mejor se adapta la aplicación. Tras un análisis y evaluación de lo que cada una ofrece y teniendo claro lo que el proyecto necesita y cual es su comportamiento, he decidido que la arquitectura de microservicios es la que mas se adapta a las necesidades de mi producto.

Es por esto por lo que se va a utilizar una arquitectura de microservicios basada en una API REST para el desarollo de la plataforma CRUT, empleando para ello el conjunto de tecnologías que la plataforma MEAN ofrece como se muestra en el siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito1/arquitectura.png "Arquitectura Proyecto")



##Servicios, microservicios y tecnologías

Como se puede apreciar en la imagen, el servidor de este tipo de arquitecturas se componen de dos partes:

- La parte del backend donde desarrolla el API REST basado en Nodejs y Express.

- La parte del frontend donde se implementa la vista del cliente mediante Angularjs.

Para implementar este tipo de arquitectura se va a utilizar la plataforma de servicios AWS. De este modo se tendrá separada la parte del servidor de los microservicios.

El servidor será desplegado en el servicio Amazon Elastic Beanstalk, en el cual se integran todas las tecnologías necesarias para su desarrollo y funcionamiento.

Por ahora se va a utilizar un sólo microservicio basado en MySQL donde se van a alojar los datos de las diferentes configuraciones de los dispotivos, y el cual correrá bajo el servicio Amazon EC2 como una máquina totalmente remota y separada del servidor.



##Provisionamiento

Para realizar el provisionamiento correspondiente a las diferentes máquinas que componen la arquitectura del proyecto se han utilizado dos de las herramientas más conocidas en este ámbito como son Ansible y Puppet. Se ha completado un primer provisionamiento de las máquinas con Ansible y una vez que se ha comprobado que todo funciona y ha ido corrrectamente se ha vuelto a hacer el mismo provisionamiento sobre las máquinas (previamente habiendo desinstalado lo que Ansible provisionó) pero esta vez desde la herramienta de Puppet.

Se han elegido estas dos herramientas software para asegurar que el aprovisionamiento se realiza correctamente independientemente del software utilizado, en este caso ambas estas implementadas con diferentes lenguajes de programación, mientras que Asible está programadoa bajo Python, Puppet lo esta echo bajo Ruby.

Se han utilizado dos instancias remotas para montar la arquitectura del proyecto, una sobre CentOS donde se instalarán todas las dependencias y se almacenarán los ficheros necesarios del proyecto para que se ejecute la API REST, y otra sobre Ubuntu donde se desplegará el microservicio de persistencia de datos basado en MySQL.

El proceso realizado para definir las instancias de las máquinas remotas se puede ver en el siguiente enlace de [creación de instancias remotas](https://jmanday.github.io/CRUT/index#definir-instancias-remotas).

El primer provisionamiento sobre ambas máquinas ha sido realizado mediante **Ansbile**, previamente siendo instalado en la máquina central desde la que se desplegará el provisionamiento como se documenta en el siguiente enlace de [provisionamiento con ansible](https://jmanday.github.io/CRUT/index#provisionamiento-1-ansible). Se han utilizado dos ficheros de provisionamiento para cada instancia remota ya que se ha modularizado las tareas como se muestran a continuación.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img26.png "Ansible-Fichero Provisionamiento AMI")


![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img27.png "Ansible-Fichero Provisionamiento AMI")


![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img28.png "Ansible-Fichero Provisionamiento Ubuntu")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img29.png "Ansible-Fichero Provisionamiento Ubuntu")


Para probar el mismo provisionamiento pero con otra herramienta diferente se ha escogido **Puppet**. Una herramienta basada en Ruby que se basa en la definición de módulos y clases para instalar paquetes y dependencias. En el siguiente enlace de [provisionamiento con puppet](https://jmanday.github.io/CRUT/index#provisionamiento-2-puppet) se puede ver la prueba de que todo se realizó correctamente. Al igual que en el provisionamiento con **Ansible**, se han utilizado dos ficheros para realizar toda la tarea de provisionamiento, uno para cada máquina virtual remota.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img5.png "Puppet-Fichero Provisionamiento AMI")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img11.png "Puppet-Fichero Provisionamiento Ubuntu")

En el siguiente [enlace](https://github.com/NestorsImagination/Sample-Multiplayer-Shooter/issues/13) se puede ver la supervisión del provisionamiento de un compañero.



##Vagrant

Se ha realizado una orquestación de tres máquinas virtuales en local y otra de dos máquinas virtuales en cloud.

Para la [orquestación local](https://jmanday.github.io/CRUT/index#orquestando-en-local) de las máquinas virtuales se ha utilizado **Virtualbox** como proveedor para definir una máquina con centos, otra con ubuntu/trusty de 64 bits y una tercerca con ubuntu/precise de 32 bits, todas ellas provisionadas mediante **Ansible** como se muestra en la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img10.png)


Para la [orquestación cloud](https://jmanday.github.io/CRUT/index#orquestando-en-cloud) de las máquinas virtuales se ha utilizado **Azure** como proveedor para definir dos máquinas con ubuntu y provisionadas a través de **Ansible** una con **MySQL** y otra con **Node**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img21.png)

En el siguiente [enlace](https://github.com/mortega87/ProyectoCC-16-17/issues/15) se puede ver la supervisión del provisionamiento de un compañero.



##Docker

Para implementar la arquitectura basada en microservicios que sigue el proyecto, se han creado dos contenedores en una instancia de Amazon. Uno de ellos creados a partir de una imagen de [mongo](https://jmanday.github.io/CRUT/index#primer-contenedor) disponible en **Docker Hub**, y otro creado con el [entorno de ejecución](https://jmanday.github.io/CRUT/index#segundo-contenedor) para el proyecto en base a una [imagen](https://hub.docker.com/r/jmanday/crut/tags/) propia definida en el fichero [Dockerfile](https://hub.docker.com/r/jmanday/crut/~/dockerfile/) y subida al repositorio de docker de **Docker Hub** a través del respositorio existente en **Github** sobre el proyecto.

Los contenedores han sido [enlazados](https://jmanday.github.io/CRUT/index#enlazar-los-contenedores) para realizar la comunicación entre ellos, como se necesita en toda arquitectura basada en microservicios. Con todo montado se ha realizado la correspondiente [comprobación](https://jmanday.github.io/CRUT/index#prueba) para ver que todo se ha realizado correctamente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img6.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img7.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img8.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img11.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img13.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img10.png)


En los siguientes enlaces e pueden ver la correcciones del hito 4 de los compañeros [Mario](https://github.com/mortega87/ProyectoCC-16-17/issues/21) y [Daniel](https://github.com/NestorsImagination/Sample-Multiplayer-Shooter/issues/25) .


##Despliegue en infraestructura virtual

Han sido muchos los servicios y tecnologías que se han utilizado para la realización diferentes tareas. Herramientas como **Docker** para crear contenedores, **Vagrant** para orquestar máquinas virtuales y **Ansible** o **Chef** entre otras para la gestión de configuraciones.

Llegado a este punto del proyecto toca realizar el despligue de la aplicación en una infraestuctura virtual. Cabe recordar que esta aplicación esta basada en una arquitectura microservicios, por lo que será necesario el uso de las herramientas mencionadas anteriormente para implementarla. 

En forma de resumen, la aplicación la podemos descomponer en el servidor principal donde se ejecuta la aplicación y el servicio de base de datos donde se implementa el modelo. El servidor será alojado en una máquina de **Azure**, mientras que el servicio de base de datos será desplegado en el PaaS **Heroku** a través de el add-on **MongoLab**.

Utilizaremos **Vagrant** como herramienta de orquestación para crear la máquina servidor con Amazon AWS como proveedor. Dicha máquina será configurada con todos los servicios necesarios tales como **Node.js**, **Express**, etc, mediante el gestor de configuraciones **Ansible**. Una vez creada y configurada la máquina servidor, se le desplegará la aplicación para que se comience a ejecutar y escuchar peticiones.

En la parte de los microservicios tenemos el mongodb, este microservicio será alojado a través de **Heroku**, añadiendo su add-on correspondiente. Otro microservicio que integrará el sistema y que también será algojado como un servicio externo desde **Heroku** será **papertrail** para el control de los logs.



### Microservicios

Este sistema implementa una arquitectura basada en microservicios, y como tal es necesario definirlos y levantarlos. Como se ha mencionado en el anterior apartado, la aplicación se compone de los microservicios de logs y base de datos, ambos desde Heroku.

Una vez registrado e iniciado sesión en dicho PaaS lo siguiente es agregar esos **add-on** a la máquina virtual como se muetra en las imagenes

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img6.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img7.png)

y como se puede ver en el panel de administrador de Heroku, los dos microservicios han sido correctamente añadidos

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img8.png)



### Despliegue del servidor

Una vez que los microservicios han sido definidos, lo siguiente es desplegar el proyecto en el servidor. Para ello haremos uso de las tecnologías vistas durante el curso como se ha mencionado en el anterior apartado.

Lo primero que tenemos que hacer es modificar los parámetros de conexión de la aplicación para que utilice como base de datos el microservicio declarado anteriormente. Será necesario entonces indicarle en el parámetro de conexión la url del microservicio de Heroku donde se debe conectar como se muestra en la imagen

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img5.png)


Con el servidor ya configurado, ahora a través de **Vagrant** vamos a definir una máquina de Azure donde el servidor será alojado. Hemos definido el siguiente fichero vagrantfile donde se especifican las características y los parámetros que tendrá dicha máquina virtual


	VAGRANTFILE_API_VERSION = '2'

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  	config.vm.box = 'azure'
  	config.vm.box_url = 'https://github.com/msopentech/	vagrant-azure/raw/master/dummy.box'

  	config.ssh.username = 'vagrant'

  	config.vm.provider :azure do |azure|
    	azure.mgmt_certificate = File.expand_path('~/.ssh/azurevagrant.key')
    	azure.mgmt_endpoint = 'https://management.core.windows.net'
  
    	azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

    	azure.storage_acct_name = '' 

    	azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2-LTS-amd64-server-20150506-en-us-30GB'
    
	    azure.vm_user = 'vagrant' 
	    azure.vm_password = 'vagrant123#@!' 
	
	    azure.vm_name = 'Ubuntu-Azure' 
	    azure.cloud_service_name = '' 
	
	    azure.vm_location = 'North Europe'

	    azure.tcp_endpoints = '3389:53389' 
	    azure.winrm_https_port = 5986
	    azure.ssh_port = '22'
	  
	    azure.winrm_transport = %w(https)
	  end
	  
	    config.vm.provision "ansible" do |ansible|
	    ansible.playbook = "playbook.yml"
	  end
  
	end

Esta máquina que será desplegada en Azure, será provisionada a través de **Ansible** con el fichero playbook correspondiente como se indica en el parámetro **congif.vm.provision** del fichero Vagrantfile descrito anteriormente.

	- hosts: azure-vagrant
  	become: yes
  	remote_user: vagrant
 
  	tasks:
   		- name: update the system
	  	  	apt: update_cache: yes
	  
	    - name: Install dependencies
	      apt: name={{ item }} state=latest
	      with_items:
	        - git
	        - curl
	        - wget
	              
	    - name: Install npm, nvm and  node
	      get_utl: url=https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh/.install.sh
	      script: install.sh
		  command: nvm install v6
		  
		- name: download source code  
		  shell: git clone https://github.com/jmanday/MEAN.git
		
		- name: install app dependencies 
		  shell: cp -r ./MEAN/Proyecto2/* /usr/src/app/ && rm -rf ./MEAN && cd /usr/src/app && npm install 


Una vez definidos los dos ficheros ejecutamos la orden de vagrant para desplegar la máquina en Azure

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img17.png)


y vemos como la máquina se ha creado correctamente

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img1.png)


![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img2.png)


por lo que probamos que todas las herramientas y servicios se han instalado correctamente, al igual que los códigos fuentes del proyecto alojado en Github

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img3.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img4.png)



### Pruebas

Con el servidor ejecutándose en una instancia de Azure y los microservicios en Heroku, lo siguiente es probar que el sistema es estable y funciona correctamente. Para ellos crearemos un nuevo registro desde la aplicación y veremos su comportamiento tanto en la base de datos como en los logs de la misma.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img9.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img10.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img11.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito5/h5-img12.png)


Como se ha podido comprobar tanto el microservicio de **mongoLab** como el de **papertrail** funcionan correctamente cuando se ha añadido un nuevo usuario al sistema, por lo que podemos decir que se ha realizado una buena integración de los microservicios con el servidor para implementar dicha arquitectura.

Desde el siguiente [enlace](http://35.167.248.75:3000/) se puede acceder a la aplicación y comprobar su funcionamiento.
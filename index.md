---
layout: index
---

# CRUT

## Descripción del problema

En el ámbito de la industria 4.0 son muchos los sistemas que continúan anclados a un entorno de ejecución que les impiden escalar y mejorar su propio rendimiento.

Son muchos los dispositivos, tecnologías, protocolos y software empleados en el desarrollo de un sistema de control industrial. Una de las principales funciones que se desarrollan en este ámbito esta orientada a la configuración de los dispositivos de control, los cuales necesitan de unos parámetros e información necesaria para poder realizar su cometido.


## Solución propuesta

CRUT (Cloud RTU Universal Tool) nace de la necesidad que hasta el momento el mundo de la industria ha vivido en el marco de la configuración sobre dispositivos de carácter programables como PLCs, RTUs, etc, encargados de controlar el correcto comportamiento de procesos industriales.

Hasta el momento, la parametrización de un dispositivo programable; en este caso particular una RTU, se realiza a través de un software de escritorio el cual debe estar físicamente conectado al dispositivo para poder enviarle los datos de configuración. Este trabajo resulta tedioso ya que la persona responsable de dicha tarea tiene que desplazarse personalmente a la localización donde se encuentren los dispositivos para poder configurarlos.

La herramienta CRUT agiliza todo ese proceso, ya que de este modo no es necesario conectarse físicamente al dispositivo para parametrizarlo. CRUT ofrece una plataforma de configuración remota desde la que es posible realizar dicha tarea en cualquier dispositivo desde cualquier situación con conexión a internet.

CRUT elimina las barreras existentes hasta ahora y agiliza las operaciones de configuración, haciendolas mas ligeras y expandibles.


## Arquitecura software

Se han estudiado los diferentes tipos de arquitecturas software para evaluar a cual de ellas mejor se adapta la aplicación. Tras un análisis y evaluación de lo que cada una ofrece y teniendo claro lo que el proyecto necesita y cual es su comportamiento, he decidido que la arquitectura de microservicios es la que mas se adapta a las necesidades de mi producto.

Es por esto por lo que se va a utilizar una arquitectura de microservicios basada en una API REST para el desarollo de la plataforma CRUT, empleando para ello el conjunto de tecnologías que la plataforma MEAN ofrece como se muestra en el siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito1/arquitectura.png "Arquitectura Proyecto")


## Servicios, microservicios y tecnologías

Como se puede apreciar en la imagen, el servidor de este tipo de arquitecturas se componen de dos partes:

- La parte del backend donde desarrolla el API REST basado en Nodejs y Express.

- La parte del frontend donde se implementa la vista del cliente mediante Angularjs.

Para implementar este tipo de arquitectura se va a utilizar la plataforma de servicios AWS. De este modo se tendrá separada la parte del servidor de los microservicios.

El servidor será desplegado en el servicio Amazon Elastic Beanstalk, en el cual se integran todas las tecnologías necesarias para su desarrollo y funcionamiento.

Por ahora se va a utilizar un sólo microservicio basado en MySQL donde se van a alojar los datos de las diferentes configuraciones de los dispotivos, y el cual correrá bajo el servicio Amazon EC2 como una máquina totalmente remota y separada del servidor.


## Provisionamiento

Para la realización de este proceso voy a utilizar dos sistemas de provisionamiento diferentes sobre dos instancias de máquinas virtuales. La primera instancia será provisonada mediante [Ansible](https://www.ansible.com/), y para la segunda se utilizará [Puppet](https://puppet.com/).


### Definir instancias remotas

Con el sistema de provisionamiento ya instalado, lo siguiente es crear la instancia remota. Para la creación y gestión de las instancias remotas se va a hacer uso de [Amazon Web Services](https://aws.amazon.com/es/), uno de los principales IaaS del mercado y que mejores servicios ofrece en los que muchas empresas tienen alojada toda su infraestructura. Se aprovechará también la licencia como estudiante que ofrecen para disfrutar de las ventajas que tiene. 

#### Definición de instancia AMI

Esta instancia se va a crear en base a una **AMI**(Amazon Machine Image) como se puede visualizar. Esta imagen de Linux viene con algunos paquetes básicos instalados como Python, el cual es necesario para poder utilizar **Ansible**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img4.png "Creación Instancia Remota")


Una vez elegido el tipo de imagen en la que se basará la instancia, lo siguiente es seleccionar el tipo de máquina a crear. Como se puede ver en la imagen, Amazon proporciona una amplia variedad de instancias que van dependiendo en función de las prestaciones que ofrece. Para nuestra instancia *instance1-ami* se escogerá una de tipo t2.micro, la cual que presenta unas características adecuadas para el uso del proyecto que vamos a desplegar.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img5.png "Creación Instancia Remota")


En el siguiente paso de la definición de la instancia remota se puede configurar con mas detalle algunos parámetros mas específicos de la máquina como son la red privada a la que va a pertencer, los roles de **IAM**(Identity and Access Magnament), etc.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img6.png "Creación Instancia Remota")


Es posible también añadirle un volumnen unidad de almacenamiento, aunque por defecto se crea con un volumen SSD de 8 GB que soporta **snapshot**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img7.png "Creación Instancia Remota")


Se le puede incluir un *tag* a la instancia remota para poder referirse a ella con un nombre descriptivo que la pueda diferenciar. Esto es útil para cuando se esta trabajando con varias máquinas remotas y cada una tiene un propósito diferente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img8.png "Creación Instancia Remota")


A través de la configuración de los grupos de seguridad dotamos a la instancia de Amazon con un conjunto de reglas para controlar el tráfico hacia la misma. De momento sólo tendrá habilitado el puerto 22 para poder realizar la conexión remota.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img9.png "Creación Instancia Remota")


En la siguiente imagen vemos una resumen de la instancia que se ha creado desde la herramienta web de **AWS**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img10.png "Creación Instancia Remota")


Nos crearemos y descargamos en la máquina local un par de claves (.pem) que serán necesarias para poder realizar conexiones hacia la máquina remota a través del protocolo ssh.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img11.png "Creación Instancia Remota")


Con todo configurado y definido, lo último que queda es lanzar la instancia.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img12.png "Creación Instancia Remota")


Como se puede ver en la lista de instancias que estan corriendo, la que nos acabamos de crear aparece con ese estado y con una lista de atributos que nos serán necesarios, como por ejemplo el dns público que lo utilizaremos para las conexiones ssh.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img13.png "Creación Instancia Remota")


Para comprobar que la instancia EC2 ha sido creada y se está ejecutando se establecerá una conexión remota ssh por medio del par de claves creadas anteriormente. Lo primero que haremos será modificarle los permisos a dicho fichero para que pueda ser leido por el usuario de la máquina remota, y a continuación ejecutamos el comando ssh para realizar la comunicación.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img14.png "Creación Instancia Remota")


#### Definición de instancia Ubuntu
 
Se han seguido los mismos pasos que en la creación de la instancia anterior, con la salvedad de que el tipo de imagen utilizada para este mircorservicio es un **Ubuntu Server**. Va a tener las mismas caracterísitcas, prestaciones, grupo de seguridad y clave pem que la máquina para el servidor.

 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img19.png "Definición instancia")
 
  ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img20.png "Definición instancia")
  
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img21.png "Definición instancia")
   
### Provionar instancias remotas

### Provisionamiento 1: ansible

Para este primer provionamiento voy a utilizar [Ansible](https://www.ansible.com/) como herramienta ya que es uno de los sisetmas más estandarizados y fácil de usar en automatización de infraestructuras junto a [Chef](https://www.chef.io/chef/). Está desarrollado en Python y no requiere aplicaciones de terceros ya que cuenta con un cliene de conexión ssh. 

La estructura y funcionamiento de **Ansible** se realiza en base a **playbooks**, archivos *yaml* que la hacen mas clara y fácilmente entendible. Ofrece la opción de incluir variables de registro en cada despliegue para poder así aplicar diferentes parámetros a cada equipo.

Una vez comentado el por qué de la elección de **Ansible** lo siguiente será instalarlo en la máquina de control o máquina local, es decir, la máquina desde la que se ejecutarán los comandos para acceder a la instancia remota. 

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img1.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img2.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img3.png "Instalación Ansible")


#### Prueba de ansible sobre la instancia AMI

Una vez creada la instancia e instalado el **ansible** en la máquina local, toca editar el fichero de *hosts* para inluir la máquina EC2 dentro de las conocidas por la herramienta de provisionamiento.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img15.png "Creación Instancia Remota")


En este fichero hemos declarado un grupo para tener clasificadas las diferentes instancias remotas. En el parámetro **private_key_file** le indicamos que clave privada debe utilizar para realizar la conexión ssh. Para asegurarnos que todo ha ido bien hacemos una pequeña prueba desde **ansible** con un **ping** hacia la máquina.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img16.png "Creación Instancia Remota")


Al indicarle el nombre del grupo solo le hará *ping* a las máquinas definidas dentro de ese grupo, en este caso sólo tenemos una y se puede ver como la respuesta ha tenido éxito.
 

#### Ficheros yaml para la instancia AMI

Con la máquina remota ejecutándose y la herramienta **ansible** configurada para poder conectarse a ella, lo siguiente será definir el provisionamiento a través de los ficheros **yaml**. Para este caso he definido dos archivos de provisionamiento, un primer archivo [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/updateSys.yml) para actualizar todos los paquetes del sistema, y un segundo fichero [node.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/node.yml) para instalar todo el entorno **nvm** junto con **npm** y **node**.
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img17.png "Fichero de provisionamiento para actualizar los paquetes")
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img18.png "Fichero de provisionamiento para instalar el entorno node, npm y nvm")
 

#### Prueba de ansible sobre la instancia Ubuntu 
 
Para cumplir con la arquitectura basada en microservicios, se va a definir otra instancia remota que será dedicada al microservcio de [MySQL](https://www.mysql.com/) y almacenar la persistencia de datos.
Vemos que todo se ha realizado correctamente una vez que se han desarrollado todos los pasos necesarios.

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img22.png "Conexión ssh a la instancia remota")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img23.png "Prueba de ansible a la instancia remota")
   

#### Ficheros yaml para la instancia Ubuntu 

Para el provisionamiento de esta instancia se han definido también dos ficheros **yaml**. El primero de ellos [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/updateSys.yml), como en el caso anterior esta orientado a la actualización del sistema y los paquetes del mismo. Con el segundo fichero [mysql.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/mysql.yml), provisionamos a la máquina con el microservicio de **MySQL** y también con **git**

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img24.png "Fichero de provisionamiento para actualizar el sistema")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img25.png "Fichero de provisionamiento para instalar MySQL y git")

Como se ha podido comprobar este primer aprovisionamiento mediante **Ansible** se ha realizado de manera correcta, desplegando a cada instancia remota las herramientas, paquetes y ficheros necesarios para el proyecto.


### Provisionamiento 2: puppet

Una vez realizado el provisionamiento de las máquinas con **Ansible**, se ha procedido a realizar el mismo tipo de provisionamiento pero esta vez usando otra herramienta diferente pero del mismo entorno como es [Puppet](https://puppet.com/). 

Es una herramienta para la gestión de la configuración de código abierto escrita en Ruby. Se compone de un lenguaje declarativo a base de módulo y clases para definir la configuración del sistema. Funciona en las distribuciones de Linux así como en múltiples sistemas Unix.

Al igual que el resto de sistemas de provisionamiento, **Puppet** se basa en la compilación de ficheros que definen una estructura para los paquetes y dependencias que se desplegarán en la instancia remota.


#### Fichero PP para la instancia AMI 

Lo siguiente será definir el fichero de provisionamiento para la instancia de AMI, es decir, para desplegar todo el entorno necesario en la máquina servidor de la API REST. En el se indicarán todas las dependencias y paquetes necesarios.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img5.png "Generar contraseña de usuario")


En la máquina remota AMI será necesario instalar **Puppet**, por lo que procedemos a ello.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img6.png "Generar contraseña de usuario")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img7.png "Generar contraseña de usuario")


El fichero de despliegue para **Puppet** se descargará en la instancia de AMI para que lo pueda ejecutarlo e instalar toda la configuración descrita en él.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img8.png "Generar contraseña de usuario")


Con el siguiente comando se instalarán todas las dependencias referenciadas en el fichero de provisionamiento, en este caso todo el entorno *nodejs* y *nvm* para la instancia AMI.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img9.png "Generar contraseña de usuario")

#### Prueba de puppet sobre la instancia AMI

Probamos que se han instaldo las dependencias y paquetes correctamente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img10.png "Generar contraseña de usuario")


#### Fichero PP para la instancia Ubuntu 

Para la instancia remota Ubuntu que contendrá el microservicio de MySQL se seguirán los mismos pasos para la instalación. Una vez realizada se definirá el fichero que definirá la estructura de paquetes y dependecias a desplegar en dicha instancia y se copiará en la máquina remota para su posterior instalación, como se muestra en las siguientes imágenes.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img11.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img1.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img2.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img3.png "Instalar mysql")


#### Prueba de puppet sobre la instancia Ubuntu

Por último lanzamos el servicio de mysql para comprobar que todo se ha realizado correctamente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img4.png "Instalar mysql")


## Vagrant
Para la realización de este hito se va a proceder a orquestar varias máquinas virtuales tanto en modo local como en cloud a través de [Vagrant](https://www.vagrantup.com/).

Lo primero en realizar es instalar **Vagrant** en la máquina local para poder trabajar con la herramienta como se muestra en la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img1.png)

### Orquestando en local
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


### Orquestando en cloud
Para realizar la orquestación de varias máquinas virtuales en cloud se va a utilizar el Iaas de [Microsoft Azure](https://azure.microsoft.com/es-es/), aprovechando el la subscripción gratis que regalan durante un mes.

Se definirán dos máquinas virtuales con Ubuntu de 64 bits, una de ellas será provisionada con [MySQL](https://www.mysql.com/) y la otra con [Node](https://nodejs.org/es/).

Lo primero que haremos será instalar el plugin de **azure** a **Vagrant** mediante el siguiente comando:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img15.png)

Una vez que se ha instalado el plugin correspondiente de manera exitosa, lo siguiente será definir los ficheros Vagranfile para las máquinas virtuales. Se definirá un fichero por cada máquina ya que cada uno de ellos llevará asociado su fichero de ansible para el respectivo provisionamiento.

Antes de comenzar a definir los ficheros de **Vagrant** es necesario añadir la "caja" (**box**) base a partir de la cual se crearán las dos máquinas virtuales:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img16.png)

Con la imagen base ya añadida al vagrant pasamos a definir los ficheros **Vagrantfile** para cada una de las máquinas virtuales que aunque serán muy parecidos y compartiran los mismos recursos a nivel de certificados de seguridad para la conexión con la máquina local, se distinguen en algunos parámetros.

Para la primera máquina se ha definido el siguiente Vagrantfile:

	VAGRANTFILE_API_VERSION = '2'

	Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = 'azure'
	config.vm.box_url = 'https://github.com/msopentech/	vagrant-azure/raw/master/dummy.box'

	config.ssh.username = 'vagrant'

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

Con el siguiente contenido en el fichero de provisionamiento para **Ansible**:

	- hosts: azurevagrant-Node
  	  become: yes
  	  remote_user: vagrant
 
  	  tasks:
   		   - name: Actualizar todos los paquetes
	  		 apt:
        		update_cache: yes
	  
    	   - name: Instalar dependencias
      		 apt: name={{ item }} state=latest
      			with_items:
        			- git
        			- curl
        			- wget
              
    	   - name: Instalar npm, nvm y  node
      		 get_utl: url=https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh/.install.sh
      		 script: install.sh
	  		 command: nvm install v6


Ejecutamos el comando de **Vagrant** para levantar la máquina virtual en proveedor de **Azure**:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img19.png)


Como se hizo con la anterior máquina virtual, en la imagen de debajo se muestra la comprobación de que todo se ha realizado correctamente:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img20.png)


Para finalizar con la orquestación de las máquinas virtuales en cloud, vamos a acceder al portal web de **Azure** para comprobar realmente que las máquinas se ha creado y se encuentran definidas en la plataforma:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito3/h3-img21.png)


Como se ha podido comprobar todo el proceso de orquestación en cloud se ha realizado satisfactoriamente y las máquinas virtuales están correctamente creadas y provisionadas, asi como disponibles para su uso.
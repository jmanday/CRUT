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

El proceso realizado para definir las instancias de las máquinas remotas se puede ver en el siguiente enlace de [creación de instancias remotas](https://github.com/jmanday/CRUT/blob/provisionamiento/README.md#definir-instancias-remotas).

El primer provisionamiento sobre ambas máquinas ha sido realizado mediante **Ansbile**, previamente siendo instalado en la máquina central desde la que se desplegará el provisionamiento como se documenta en el siguiente enlace de [provisionamiento con ansible](https://github.com/jmanday/CRUT/tree/provisionamiento#provisionamiento-1-ansible). Se han utilizado dos ficheros de provisionamiento para cada instancia remota ya que se ha modularizado las tareas como se muestran a continuación.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img26.png "Ansible-Fichero Provisionamiento AMI")


![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img27.png "Ansible-Fichero Provisionamiento AMI")


![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img28.png "Ansible-Fichero Provisionamiento Ubuntu")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img29.png "Ansible-Fichero Provisionamiento Ubuntu")


Para probar el mismo provisionamiento pero con otra herramienta diferente se ha escogido **Puppet**. Una herramienta basada en Ruby que se basa en la definición de módulos y clases para instalar paquetes y dependencias. En el siguiente enlace de [provisionamiento con puppet](https://github.com/jmanday/CRUT/tree/provisionamiento#provisionamiento-2-puppet) se puede ver la prueba de que todo se realizó correctamente. Al igual que en el provisionamiento con **Ansible**, se han utilizado dos ficheros para realizar toda la tarea de provisionamiento, uno para cada máquina virtual remota.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img5.png "Puppet-Fichero Provisionamiento AMI")

<<<<<<< HEAD
![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img11.png "Puppet-Fichero Provisionamiento Ubuntu")
=======
### Definición de instancia Ubuntu
 
Se han seguido los mismos pasos que en la creación de la instancia anterior, con la salvedad de que el tipo de imagen utilizada para este mircorservicio es un **Ubuntu Server**. Va a tener las mismas caracterísitcas, prestaciones, grupo de seguridad y clave pem que la máquina para el servidor.

 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img19.png "Definición instancia")
 
  ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img20.png "Definición instancia")
  
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img21.png "Definición instancia")
   
##Provionar instancias remotas

### Provisionamiento 1: ansible

Para este primer provionamiento voy a utilizar [Ansible](https://www.ansible.com/) como herramienta ya que es uno de los sisetmas más estandarizados y fácil de usar en automatización de infraestructuras junto a [Chef](https://www.chef.io/chef/). Está desarrollado en Python y no requiere aplicaciones de terceros ya que cuenta con un cliene de conexión ssh. 

La estructura y funcionamiento de **Ansible** se realiza en base a **playbooks**, archivos *yaml* que la hacen mas clara y fácilmente entendible. Ofrece la opción de incluir variables de registro en cada despliegue para poder así aplicar diferentes parámetros a cada equipo.

Una vez comentado el por qué de la elección de **Ansible** lo siguiente será instalarlo en la máquina de control o máquina local, es decir, la máquina desde la que se ejecutarán los comandos para acceder a la instancia remota. 

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img1.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img2.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img3.png "Instalación Ansible")


### Prueba de ansible sobre la instancia AMI

Una vez creada la instancia e instalado el **ansible** en la máquina local, toca editar el fichero de *hosts* para inluir la máquina EC2 dentro de las conocidas por la herramienta de provisionamiento.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img15.png "Creación Instancia Remota")


En este fichero hemos declarado un grupo para tener clasificadas las diferentes instancias remotas. En el parámetro **private_key_file** le indicamos que clave privada debe utilizar para realizar la conexión ssh. Para asegurarnos que todo ha ido bien hacemos una pequeña prueba desde **ansible** con un **ping** hacia la máquina.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img16.png "Creación Instancia Remota")


Al indicarle el nombre del grupo solo le hará *ping* a las máquinas definidas dentro de ese grupo, en este caso sólo tenemos una y se puede ver como la respuesta ha tenido éxito.
 

### Ficheros yaml para la instancia AMI

Con la máquina remota ejecutándose y la herramienta **ansible** configurada para poder conectarse a ella, lo siguiente será definir el provisionamiento a través de los ficheros **yaml**. Para este caso he definido dos archivos de provisionamiento, un primer archivo [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/updateSys.yml) para actualizar todos los paquetes del sistema, y un segundo fichero [node.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/node.yml) para instalar todo el entorno **nvm** junto con **npm** y **node**.
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img17.png "Fichero de provisionamiento para actualizar los paquetes")
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img18.png "Fichero de provisionamiento para instalar el entorno node, npm y nvm")
 

### Prueba de ansible sobre la instancia Ubuntu 
 
Para cumplir con la arquitectura basada en microservicios, se va a definir otra instancia remota que será dedicada al microservcio de [MySQL](https://www.mysql.com/) y almacenar la persistencia de datos.
Vemos que todo se ha realizado correctamente una vez que se han desarrollado todos los pasos necesarios.

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img22.png "Conexión ssh a la instancia remota")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img23.png "Prueba de ansible a la instancia remota")
   

### Ficheros yaml para la instancia Ubuntu 

Para el provisionamiento de esta instancia se han definido también dos ficheros **yaml**. El primero de ellos [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/updateSys.yml), como en el caso anterior esta orientado a la actualización del sistema y los paquetes del mismo. Con el segundo fichero [mysql.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/mysql.yml), provisionamos a la máquina con el microservicio de **MySQL** y también con **git**

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img24.png "Fichero de provisionamiento para actualizar el sistema")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img25.png "Fichero de provisionamiento para instalar MySQL y git")

Como se ha podido comprobar este primer aprovisionamiento mediante **Ansible** se ha realizado de manera correcta, desplegando a cada instancia remota las herramientas, paquetes y ficheros necesarios para el proyecto.


### Provisionamiento 2: puppet

Una vez realizado el provisionamiento de las máquinas con **Ansible**, se ha procedido a realizar el mismo tipo de provisionamiento pero esta vez usando otra herramienta diferente pero del mismo entorno como es [Puppet](https://puppet.com/). 

Es una herramienta para la gestión de la configuración de código abierto escrita en Ruby. Se compone de un lenguaje declarativo a base de módulo y clases para definir la configuración del sistema. Funciona en las distribuciones de Linux así como en múltiples sistemas Unix.

Al igual que el resto de sistemas de provisionamiento, **Puppet** se basa en la compilación de ficheros que definen una estructura para los paquetes y dependencias que se desplegarán en la instancia remota.


### Fichero PP para la instancia AMI 

Lo siguiente será definir el fichero de provisionamiento para la instancia de AMI, es decir, para desplegar todo el entorno necesario en la máquina servidor de la API REST. En el se indicarán todas las dependencias y paquetes necesarios.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img5.png "Generar contraseña de usuario")


En la máquina remota AMI será necesario instalar **Puppet**, por lo que procedemos a ello.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img6.png "Generar contraseña de usuario")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img7.png "Generar contraseña de usuario")


El fichero de despliegue para **Puppet** se descargará en la instancia de AMI para que lo pueda ejecutarlo e instalar toda la configuración descrita en él.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img8.png "Generar contraseña de usuario")


Con el siguiente comando se instalarán todas las dependencias referenciadas en el fichero de provisionamiento, en este caso todo el entorno *nodejs* y *nvm* para la instancia AMI.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img9.png "Generar contraseña de usuario")

### Prueba de puppet sobre la instancia AMI

Probamos que se han instaldo las dependencias y paquetes correctamente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img10.png "Generar contraseña de usuario")


### Fichero PP para la instancia Ubuntu 

Para la instancia remota Ubuntu que contendrá el microservicio de MySQL se seguirán los mismos pasos para la instalación. Una vez realizada se definirá el fichero que definirá la estructura de paquetes y dependecias a desplegar en dicha instancia y se copiará en la máquina remota para su posterior instalación, como se muestra en las siguientes imágenes.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img11.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img1.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img2.png "Instalar mysql")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img3.png "Instalar mysql")


### Prueba de puppet sobre la instancia Ubuntu

Por último lanzamos el servicio de mysql para comprobar que todo se ha realizado correctamente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img4.png "Instalar mysql")
>>>>>>> provisionamiento

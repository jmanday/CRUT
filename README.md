# HITO 2 - PROVISIONAMIENTO DE MÁQUINAS VIRTUALES

## Introducción
Para la realización de este hito voy a utilizar dos sistemas de provisionamiento diferentes sobre dos instancias de máquinas virtuales. La primera instancia será provisonada mediante [Ansible](https://www.ansible.com/), y para la segunda se utilizará [Puppet](https://puppet.com/).


## Definir instancias remotas

Con el sistema de provisionamiento ya instalado, lo siguiente es crear la instancia remota. Para la creación y gestión de las instancias remotas se va a hacer uso de [Amazon Web Services](https://aws.amazon.com/es/), uno de los principales IaaS del mercado y que mejores servicios ofrece en los que muchas empresas tienen alojada toda su infraestructura. Se aprovechará también la licencia como estudiante que ofrecen para disfrutar de las ventajas que tiene. 

### Definición de instancia AMI

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
 

### Ficheros yaml

Con la máquina remota ejecutándose y la herramienta **ansible** configurada para poder conectarse a ella, lo siguiente será definir el provisionamiento a través de los ficheros **yaml**. Para este caso he definido dos archivos de provisionamiento, un primer archivo [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/updateSys.yml) para actualizar todos los paquetes del sistema, y un segundo fichero [node.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ami/node.yml) para instalar todo el entorno **nvm** junto con **npm** y **node**.
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img17.png "Fichero de provisionamiento para actualizar los paquetes")
 
 ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img18.png "Fichero de provisionamiento para instalar el entorno node, npm y nvm")
 

### Prueba de ansible sobre la instancia Ubuntu 
 
Para cumplir con la arquitectura basada en microservicios, se va a definir otra instancia remota que será dedicada al microservcio de [MySQL](https://www.mysql.com/) y almacenar la persistencia de datos.
Vemos que todo se ha realizado correctamente una vez que se han desarrollado todos los pasos necesarios.

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img22.png "Conexión ssh a la instancia remota")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img23.png "Prueba de ansible a la instancia remota")
   

### Ficheros yaml

Para el provisionamiento de esta instancia se han definido también dos ficheros **yaml**. El primero de ellos [updateSys.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/updateSys.yml), como en el caso anterior esta orientado a la actualización del sistema y los paquetes del mismo. Con el segundo fichero [mysql.yml](https://github.com/jmanday/CRUT/blob/provisionamiento/ansible/playbooks/ubuntu/mysql.yml), provisionamos a la máquina con el microservicio de **MySQL** y también con **git**

   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img24.png "Fichero de provisionamiento para actualizar el sistema")
   
   ![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/ansible/h2-img25.png "Fichero de provisionamiento para instalar MySQL y git")

Como se ha podido comprobar este primer aprovisionamiento mediante **Ansible** se ha realizado de manera correcta, desplegando a cada instancia remota las herramientas, paquetes y ficheros necesarios para el proyecto.


### Provisionamiento 2: puppet

Una vez realizado el provisionamiento de las máquinas con **Ansible**, se ha procedido a realizar el mismo tipo de provisionamiento pero esta vez usando otra herramienta diferente pero del mismo entorno como es [Puppet](https://puppet.com/). 

Es una herramienta para la gestión de la configuración de código abierto escrita en Ruby. Se compone de un lenguaje declarativo a base de módulo y clases para definir la configuración del sistema. Funciona en las distribuciones de Linux así como en múltiples sistemas Unix.

Al igual que el resto de sistemas de provisionamiento, **Puppet** se basa en la compilación de ficheros que definen una estructura para los paquetes y dependencias que se desplegarán en la instancia remota.

Ante de definir dicho fichero es necesario crear una contraseña de usuario para linux en **Puppet**, para ello se ha utilizado la herramienta **openSSL** como se muestra a continuación.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img1.png "Generar contraseña de usuario")


Lo siguiente será definir el fichero de provisionamiento para la instancia de AMI, es decir, para desplegar todo el entorno necesario en la máquina servidor de la API REST. En el se indicarán todas las dependencias y paquetes necesarios.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img2.png "Generar contraseña de usuario")


En la máquina remota AMI será necesario instalar **Puppet**, por lo que procedemos a ello.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/puppet/h2-img3.png "Generar contraseña de usuario")


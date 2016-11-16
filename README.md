# HITO 2


## Introducción
Para la realización de este hito voy a utilizar dos sistemas de provisionamiento diferentes sobre dos instancias de máquinas virtuales. La primera instancia será provisonada mediante [Ansible](https://www.ansible.com/), y para la segunda se utilizará [Puppet](https://puppet.com/).

## Primer provisionamiento
Para este primer provionamiento voy a utilizar [Ansible](https://www.ansible.com/) como herramienta ya que es uno de los sisetmas más estandarizados y fácil de usar en automatización de infraestructuras junto a [Chef](https://www.chef.io/chef/). Está desarrollado en Python y no requiere aplicaciones de terceros ya que cuenta con un cliene de conexión ssh. 

La estructura y funcionamiento de **Ansible** se realiza en base a **playbooks**, archivos *yaml* que la hacen mas clara y fácilmente entendible. Ofrece la opción de incluir variables de registro en cada despliegue para poder así aplicar diferentes parámetros a cada equipo.

Una vez comentado el por qué de la elección de **Ansible** lo siguiente será instalarlo en la máquina de control o máquina local, es decir, la máquina desde la que se ejecutarán los comandos para acceder a la instancia remota. 

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img1.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img2.png "Instalación Ansible")

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img3.png "Instalación Ansible")

Con el sistema de provisionamiento ya instalado, lo siguiente es crear la instancia remota. Para la creación y gestión de las instancias remotas se va a hacer uso de [Amazon Web Services](https://aws.amazon.com/es/), uno de los principales IaaS del mercado y que mejores servicios ofrece, en los que muchas empresas tienen alojada toda su infraestructura. Se aprovechará también la licencia como estudiante que ofrecen para disfrutar de las ventajas que tiene. 

Esta instancia se va a crear en base a una **AMI**(Amazon Machine Image) como se puede visualizar. Esta imagen de Linux viene con algunos paquetes básicos instalados como Python, el cual es necesario para poder utilizar **Ansible**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img4.png "Creación Instancia Remota")


Una vez elegido el tipo de imagen a desplegar en la instancia, lo siguiente es seleccionar el tipo de máquina a crear. Como se puede ver en la imagen, Amazon proporciona una amplia variedad de instancias que van dependiendo en función de las prestaciones que ofrece. Para nuestra instancia *instance1-ami* se escogerá una de tipo t2.micro, la cual que presenta unas características adecuadas para el uso del proyecto que vamos a desplegar.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img5.png "Creación Instancia Remota")


En el siguiente paso de la definición de la instancia remota, se puede configurar con mas detalle algunos parámetros mas específicos de la máquina como son la red privada a la que va a pertencer, los roles de **IAM**(Identity and Access Magnament), etc.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img6.png "Creación Instancia Remota")


Es posible también añadirle un volumnen unidad de almacenamiento, aunque por defecto se crea con un volumen SSD de 8 GB que soporta **snapshot**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img7.png "Creación Instancia Remota")


Se le puede incluir un *tag* a la instancia remota para poder referirse a ella con un nombre descriptivo que la pueda diferenciar. Esto es útil para cuando se esta trabajando con varias máquinas remotas y cada una tiene un propósito diferente.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img8.png "Creación Instancia Remota")


A través de la configuración de los grupos de seguridad dotamos a la instancia de Amazon con un conjunto de reglas para controlar el tráfico hacia la misma.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img9.png "Creación Instancia Remota")


En la siguiente imagen vemos una resumen de la instancia que se ha creado desde la herramienta web de **AWS**.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img10.png "Creación Instancia Remota")


Nos crearemos un par de claves (.perm) que serán necesarias para poder realizar conexiones hacia la máquina remota a través del protocolo ssh.
![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img11.png "Creación Instancia Remota")


Con todo configurado y definido, lo último que queda es lanzar la instancia.
![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img12.png "Creación Instancia Remota")

Como se puede ver en la lista de instancias que estan corriendo, la que nos acabamos de crear aparece con ese estado y con una lista de atributos que nos serán necesarios, como por ejemplo el dns público que lo utilizaremos para las conexiones ssh.
![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito2/h2-img13.png "Creación Instancia Remota")
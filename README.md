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


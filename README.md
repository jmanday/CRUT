#HITO 4 - CREACIÓN DE UN ENTORNO DE PRUEBAS PARA LA APLICACIÓN USANDO CONTENEDORES

##Introducción
Para que la realización de este hito implemente la arquitectura de microservicios en la que está basada la aplicación será necesario dos contenedores, uno de ellos basado en una imagen con mongodb para el microservicio de la base de datos, mientras que el otro estará basado en un imagen con todo el entorno de node y el proyecto.

Toda la infraestructura mencionada será alojada en una máquina de Amazon como se podrá comprobar en las diferentes tareas.

##Configuración de máquina en Amazon
Lo primero que se va a realizar es la instalación de **Docker** en la máquina de Amazon para poder trabajar con ella.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img1.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img2.png)


##Primer contenedor
Una vez instalado **docker** en la instancia de Amazon, lo siguiente es crear un contenedor con MySQL. Para este primer contendor vamos a tomar una imagen de las que ya existen en el repositorio de **docker**, ya que no es necesario definir la imagen debido a que sólo necesitará tener instalado **MongoDB**.

Pasamos a ver que imagenes con **MongoDB** existen disponibles en el repositorio de **docker** con el comando *search* como se muestra en la imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img3.png)

De las imágenes disponibles eligiremos la primera *mongo*, ya que es oficial de mongo y no de un tercero, y se ajusta más a lo que la aplicación necesita, por lo que la hace la más apropiada. Creamos el contenedor en base a esa imagen, ejecutaremos el comando para conectarnos a él y comprobar que **mongo** se está ejecutando dentro del mismo.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img4.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img5.png)


##Segundo contenedor
Para este segundo contenedor partiremos de una imagen creada en base a un fichero *Dockerfile* que será definido a medida con todas las herramientas y dependencias necesarias para crear el entorno de ejecución de node, descargarse el repositorio del proyecto y lanzarlo dentro del propio contenedor.

El fichero **Dockerfile** presenta la siguiente estructura:

	FROM node:argon
	MAINTAINER Jesús García Manday "jmanday@gmail.com"

	#Update argon
	RUN apt-get update
	
	#Install git
	RUN apt-get install git
	
	#Create app directory
	RUN mkdir -p /usr/src/app
	WORKDIR /usr/src/app
	
	#Download the source project
	RUN git clone https://github.com/jmanday/MEAN.git
	
	#Install app dependencies
	RUN cp -r ./MEAN/Proyecto2/* /usr/src/app/
	RUN rm -rf ./MEAN
	RUN npm install
	
	#Bundle app source
	#COPY . /usr/src/app
	
	EXPOSE 3000
	CMD [ "npm", "start" ]

como se puede apreciar esta imagen creada a partir del anterior *Dockerfile* viene con el entorno de node instalado, asi como git. Se clona el repositorio del proyecto, instala todas las dependencias necesarias para el mismo y lo ejecuta, quedando el servidor en escucha por el puerto 3000.

Una vez definido el fichero *Dockerfile* nos crearemos la imagen y la almacenaremos en un repositorio creado en [Docker Hub](https://hub.docker.com/) llamado **jmanday/crut**.	
![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img6.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img7.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img8.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img9.png)

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img10.png)


Como se ha podido apreciar en las imágenes anteriores, la imagen se ha creado correctamente en base el fichero *Dockerfile* y ha sido alojada en el repositorio de imagenes de docker para su uso general, por lo que si alguien necesita esa imagen con esos mismos paquetes solo tiene que buscarla.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img11.png)


Lo próximo será crear el contenedor en base a esa iamgen.

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img12.png)


Se puede ver como los dos contenedores han sido creados correctamente en la siguiente imagen:

![alt text](https://raw.githubusercontent.com/jmanday/Images/master/CRUT/Hito4/h4-img13.png)

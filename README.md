# MPLACE

# Creacion de Usuario en MySQL

```mysql
CREATE USER myUser@localhost IDENTIFIED BY 'myPassword#1';
GRANT ALL PRIVILEGES ON * . * TO myUser@localhost;
FLUSH PRIVILEGES;
```

## Comandos Basicos Ubuntu
ls: Lista los archivos y directorios en el directorio actual.

cd [directorio]: Cambia al directorio especificado.

mkdir [nombre_directorio]: Crea un nuevo directorio.

touch [nombre_archivo]: Crea un nuevo archivo.

cp [archivo_origen] [archivo_destino]: Copia un archivo.

mv [archivo_origen] [archivo_destino]: Mueve o renombra un archivo.

rm [archivo]: Elimina un archivo.

rmdir [directorio]: Elimina un directorio vacío.

sudo [comando]: Ejecuta un comando como superusuario.

apt-get install [paquete]: Instala un nuevo paquete.

apt-get update: Actualiza la lista de paquetes disponibles.

apt-get upgrade: Actualiza todos los paquetes instalados.
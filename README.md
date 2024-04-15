# Earthquake-records

Información de dependencias ó herramientas usadas:
- ** Services: Sismic Data Service {URI: open-uri, Net::HTTP: net/http, JSON: json }

## 🔧 Características:

- **Solicitar Información a la API**: El proyecto realiza solicitudes HTTP con método GET para obtener información de una API externa y la persiste en una base de datos local.

- **Persistencia de Comentarios**: Los usuarios pueden crear comentarios que se asocian a una "feature" previamente persistida en la base de datos. Estos comentarios también se almacenan en la base de datos.

- **Acceso a Datos desde la Consola**: Se ha implementado el archivo `seed.rb` para vericar los datos directamente desde la consola para realizar pruebas o consultas de la información obtenida de la API.

## 📋 Requisitos

- **Requisito 1**: Ruby "3.1.2"
- **Requisito 2**: Rails "~> 7.1.3", ">= 7.1.3.2"


```bash
# Ejemplo de comandos de instalación
git clone https://github.com/MRFA01/earthquake-records
cd earthquake-records
bundle install
rails generate simple_form:install --bootstrap"

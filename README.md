# ProyectoLenguaje

# SAVA EXPRESS
Una aplicación móvil para la administración de paquetería desde Estados Unidos,
permitiendo el rastreo, análisis y filtrado de los distintos paquetes desde el almacen.




## Compilación del Backend del Proyecto 

**PASO 1:**

Clonar el repositorio usando el link:

```
https://github.com/Cmenesess/ProyectoLenguaje.git
```

**PASO 2:**
Ir a la ruta /BackendProyecto/config/ y configurar el archivo config.json, para poder realizar una correcta 
conección a la Base de datos.

Después ejecutar el comando:
```
npm install 
```

**PASO 3:**

Para realizar las migraciones a la base de datos es imporante tener previamente instalado Sequelize
para luego ejecutar el comando:
```
npx sequelize db:migrate
```

**PASO 4:**

Ejecutar los distintos Scripts SQL para la inicialización de datos y finalmente ejecutar el comando:
```
npm run devstart
```
Finalmente estara corriendo en el puerto 4000 el backend

### Estructura de las carpetas del Backend
Las Carpetas Core y sus distintos propósitos
```
BackendProyecto/
|- config       # Archivo de configuración para la base de datos
|- Controllers  # Controladores ORM de Modelos con Sequelize
|- Models       # Modelos
|- Routes       # Rutas de la REST API
| app.js        # MAIN APP del Backend
```


# Sava Express Mobile

Aplicación Móvil creada usando el Framework de Flutter para el desarrollo de dispositivos móviles 

## Compilación del proyecto FrontEnd

Previamente a ejecutar los pasos se debe poseer los SDK de Flutter y Android o IOS dependiendo del simlulador que vayan a usar. Tener activado el simulador o conectado un dispositivo móvil.
**PASO 1:**
Dirigirse a la ruta /FrontProyecto/ y ejecutar el comando:

```
flutter run 
```
Ejecutar este comando primero importará todas las dependendencias de páquetes de forma automática


### Estructura del proyecto
La estrucutra de los directorios Core del proyecto.

```
FrontProyecto/
|- android
|- build
|- ios
|- lib
|- linux
|- macos
|- test
|- web
|- windows
```


```
lib/
|- constants/
|- models/
|- providers/
|- screens/
|- utils/
|- widgets/
|- main.dart
```

### Modelos

Las Estructuras de las clases principales del proyecto, cómo son el usuario y los distintos paquetes.

### Screens

Las distintas pantallas de la aplicación conteniendo los Widgets de Flutter para la creación del UI.

### Providers
Distintos archivos .dart que realizan la conección a la REST API y Cargan los datos requeridos en formato JSON, en función 
de las rutas de la API.

### Widgets
Contiene los Widgets más complejos de la aplicación, y son separados para poder modularizar mejor la aplicación.

### Main

El Main del proyecto donde se inicializa la aplicación MaterialApp(), asignandole las rutas de las distintas Screens.

### Routes

Aqui Definimos las distintas Rutas de la Aplicación MaterialApp

```dart
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(dividerColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: 'SavaExpress',
      initialRoute: "login",
      routes: {
        "login": (_) => const LoginScreen(),
        "registration": (_) => const RegistrationScreen(),
        "home_client": (_) => const HomeClientScreen()
      },
    );
  }
```
### GIF VIDEO  </br>
<p align="center">
![Alt Text](/Sava.gif)
  <p>

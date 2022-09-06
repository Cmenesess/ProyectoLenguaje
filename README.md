# ProyectoLenguaje

# SAVA EXPRESS
Una aplicación móvil para la administración de paquetería desde Estados Unidos,
permitiendo el rastreo, análisis y filtrado de los distintos paquetes desde el almacen.




## Compilación del Proyecto

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



### Paquetes Dart Utilizados

* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Encryption](https://github.com/xxtea/xxtea-dart)
* [Validation](https://github.com/dart-league/validators)
* [Notifications](https://github.com/AndreHaueisen/flushbar)
* [Json Serialization](https://github.com/dart-lang/json_serializable)

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






### Routes

This file contains all the routes for your application.

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
        "home_client": (_) => const HomeClientScreen(),
        "historial_client": (_) => const HistorialClientScreen()
      },
    );
  }
```



### GIF VIDEO  </br>
![Alt Text](/Sava.gif)

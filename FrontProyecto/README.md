# Sava Express Mobile

Mobile application to connect the SavaExpress system with your customers.

## Instalation Guide

**Step 1:**

Download or clone this repo by using the link below:

```

```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run the project.
```
flutter run lib/main.dart 
```

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
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

Here is the folder structure we have been using in this project

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

### Constants

This directory contains all the application level constants.

### Models

All the business logic of your application will go into this directory, it represents the data layer of your application.

### Screens

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory.

### Utils

Contains the common file(s) and utilities used in a project.

### Widgets

Contains the common widgets that are shared across multiple screens.

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

### CI/CD Tool

This project use CircleCI.

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

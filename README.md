# Integración Flutter + Firebase

Aplicación Flutter en blanco configurada para conectarse con Firebase.

## 📋 Requisitos Previos

- ✅ Flutter SDK (versión 3.38.1) - **Ya instalado**
- ✅ Dart SDK - **Incluido con Flutter**
- ✅ FlutterFire CLI - **Ya instalado**
- ✅ Dependencias del proyecto - **Ya instaladas**
- Cuenta de Google para Firebase
- Android Studio / Xcode (opcional, para desarrollo móvil)

## 🚀 Configuración Inicial

> **Nota**: Flutter y FlutterFire CLI ya están instalados. Si necesitas reinstalar, consulta `INSTALACION_FLUTTER.md`

### 1. Crear Proyecto en Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Agregar proyecto" o "Crear un proyecto"
3. Ingresa el nombre del proyecto
4. Sigue las instrucciones para completar la creación

### 2. Configurar Firebase para Android

1. En Firebase Console, ve a **Configuración del proyecto** (ícono de engranaje)
2. Haz clic en "Agregar app" y selecciona **Android**
3. Ingresa el nombre del paquete: `com.example.integracion_flutter_firebase`
4. Descarga el archivo `google-services.json`
5. Coloca el archivo en: `android/app/google-services.json`

### 3. Configurar Firebase para iOS

1. En Firebase Console, ve a **Configuración del proyecto**
2. Haz clic en "Agregar app" y selecciona **iOS**
3. Ingresa el Bundle ID: `com.example.integracionFlutterFirebase`
4. Descarga el archivo `GoogleService-Info.plist`
5. Coloca el archivo en: `ios/Runner/GoogleService-Info.plist`

### 4. Configurar Firebase con FlutterFire CLI

> **Nota**: FlutterFire CLI ya está instalado. Si necesitas reinstalarlo, ejecuta: `dart pub global activate flutterfire_cli`

Ejecuta el siguiente comando en la raíz del proyecto:

```bash
flutterfire configure
```

Este comando:
- Te pedirá que selecciones tu proyecto de Firebase
- Generará automáticamente el archivo `lib/firebase_options.dart`
- Configurará las plataformas que selecciones (Android, iOS, Web, etc.)

> **Nota**: Las dependencias ya están instaladas. Si necesitas reinstalarlas, ejecuta: `flutter pub get`

## 🏃 Ejecutar la Aplicación

```bash
# Para Android
flutter run

# Para iOS
flutter run

# Para Web
flutter run -d chrome
```

## 📦 Dependencias de Firebase Incluidas

- `firebase_core`: Core de Firebase
- `firebase_auth`: Autenticación
- `cloud_firestore`: Base de datos Firestore
- `firebase_storage`: Almacenamiento de archivos
- `firebase_analytics`: Analytics

Puedes agregar más dependencias según tus necesidades en `pubspec.yaml`.

## 📝 Notas Importantes

- Los archivos `google-services.json` y `GoogleService-Info.plist` están en `.gitignore` por seguridad
- Después de ejecutar `flutterfire configure`, el archivo `firebase_options.dart` se generará automáticamente
- Asegúrate de tener configurado correctamente el SDK de Flutter antes de ejecutar la app

## 🔧 Solución de Problemas

### Error: "FirebaseApp not initialized"
- Asegúrate de haber ejecutado `flutterfire configure`
- Verifica que `firebase_options.dart` existe y tiene la configuración correcta

### Error en Android: "google-services.json not found"
- Verifica que el archivo está en `android/app/google-services.json`
- Asegúrate de que el `package_name` en Firebase coincida con el de tu app

### Error en iOS: "GoogleService-Info.plist not found"
- Verifica que el archivo está en `ios/Runner/GoogleService-Info.plist`
- Asegúrate de que el Bundle ID en Firebase coincida con el de tu app

## 📚 Recursos

- [Documentación de Flutter](https://flutter.dev/docs)
- [Documentación de Firebase para Flutter](https://firebase.flutter.dev/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)


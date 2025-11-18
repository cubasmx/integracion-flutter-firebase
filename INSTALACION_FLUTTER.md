# Guía de Instalación de Flutter en Linux

## Opción 1: Instalación Manual (Recomendada)

### 1. Descargar Flutter

```bash
cd ~
git clone https://github.com/flutter/flutter.git -b stable
```

### 2. Agregar Flutter al PATH

Agrega estas líneas a tu archivo `~/.zshrc`:

```bash
export PATH="$PATH:$HOME/flutter/bin"
```

Luego recarga la configuración:

```bash
source ~/.zshrc
```

### 3. Verificar la Instalación

```bash
flutter doctor
```

Este comando verificará que todo esté correctamente instalado y te indicará qué dependencias faltan.

### 4. Instalar Dependencias Faltantes

Flutter doctor te dirá qué necesitas instalar. Comúnmente necesitarás:

```bash
# Para desarrollo Android
sudo apt-get update
sudo apt-get install -y libglu1-mesa
```

## Opción 2: Instalación con Snap (Más Rápida)

```bash
sudo snap install flutter --classic
```

Luego verifica:

```bash
flutter doctor
```

## Después de Instalar Flutter

Una vez que Flutter esté instalado, podrás:

1. Instalar FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Agregar FlutterFire CLI al PATH (agrega a ~/.zshrc):
```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

3. Instalar dependencias del proyecto:
```bash
cd /home/cubasmx/Documentos/integracion-flutter-firebase
flutter pub get
```

4. Configurar Firebase:
```bash
flutterfire configure
```


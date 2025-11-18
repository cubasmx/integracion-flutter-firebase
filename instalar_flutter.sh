#!/bin/bash

# Script de instalación de Flutter para Linux
# Este script instala Flutter y configura el entorno básico

set -e

echo "🚀 Instalando Flutter..."

# Verificar si Flutter ya está instalado
if command -v flutter &> /dev/null; then
    echo "✅ Flutter ya está instalado"
    flutter --version
    exit 0
fi

# Opción 1: Instalación con Git (Recomendada)
echo "📥 Descargando Flutter desde GitHub..."
cd ~
if [ -d "flutter" ]; then
    echo "⚠️  El directorio flutter ya existe. Actualizando..."
    cd flutter
    git pull
else
    git clone https://github.com/flutter/flutter.git -b stable
fi

# Agregar Flutter al PATH en .zshrc
echo "🔧 Configurando PATH..."
if ! grep -q "flutter/bin" ~/.zshrc; then
    echo '' >> ~/.zshrc
    echo '# Flutter' >> ~/.zshrc
    echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
    echo "✅ PATH agregado a ~/.zshrc"
else
    echo "⚠️  Flutter ya está en el PATH"
fi

# Agregar FlutterFire CLI al PATH
if ! grep -q ".pub-cache/bin" ~/.zshrc; then
    echo '' >> ~/.zshrc
    echo '# FlutterFire CLI' >> ~/.zshrc
    echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
    echo "✅ FlutterFire CLI PATH agregado"
fi

# Recargar configuración
export PATH="$PATH:$HOME/flutter/bin"

echo ""
echo "✅ Flutter instalado correctamente"
echo ""
echo "📋 Próximos pasos:"
echo "1. Cierra y vuelve a abrir la terminal, o ejecuta: source ~/.zshrc"
echo "2. Ejecuta: flutter doctor"
echo "3. Instala las dependencias que falten según las indicaciones"
echo "4. Luego ejecuta: dart pub global activate flutterfire_cli"
echo "5. Finalmente: cd $(pwd) && flutterfire configure"


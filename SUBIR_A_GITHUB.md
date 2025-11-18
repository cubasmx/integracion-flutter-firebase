# Subir el Repositorio a GitHub

## Paso 1: Crear el Repositorio en GitHub

1. Ve a https://github.com/new
2. Nombre del repositorio: `integracion-flutter-firebase`
3. Descripción (opcional): "Aplicación Flutter con integración de Firebase y API de Pokémon"
4. **NO** marques "Initialize this repository with a README" (ya tenemos uno)
5. Haz clic en "Create repository"

## Paso 2: Conectar y Subir

Después de crear el repositorio, GitHub te mostrará comandos. Ejecuta estos en tu terminal:

```bash
cd /home/cubasmx/Documentos/integracion-flutter-firebase

# Agregar el remoto (reemplaza TU_USUARIO con tu usuario de GitHub)
git remote add origin https://github.com/TU_USUARIO/integracion-flutter-firebase.git

# Cambiar a la rama main (si no estás ya en ella)
git branch -M main

# Subir el código
git push -u origin main
```

## Alternativa: Usar SSH

Si prefieres usar SSH en lugar de HTTPS:

```bash
git remote add origin git@github.com:TU_USUARIO/integracion-flutter-firebase.git
git push -u origin main
```

## Verificar

Después de hacer push, puedes verificar en:
https://github.com/TU_USUARIO/integracion-flutter-firebase


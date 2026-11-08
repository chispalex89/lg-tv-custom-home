#!/bin/bash

# WebOS Custom Launcher - Setup Script
# Este script configura el entorno de desarrollo para webOS

set -e  # Exit on error

echo "🚀 WebOS Custom Launcher - Setup Script"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

# Check Node.js
echo "1️⃣  Verificando Node.js..."
if command -v node &> /dev/null; then
  NODE_VERSION=$(node -v)
  print_status "Node.js instalado: $NODE_VERSION"
  
  # Check if version >= 14
  NODE_MAJOR=$(echo $NODE_VERSION | cut -d'v' -f2 | cut -d'.' -f1)
  if [ "$NODE_MAJOR" -lt 14 ]; then
    print_error "Node.js debe ser versión 14.x o superior"
    exit 1
  fi
else
  print_error "Node.js no está instalado"
  echo "Descárgalo desde: https://nodejs.org/"
  exit 1
fi

# Check npm
echo ""
echo "2️⃣  Verificando npm..."
if command -v npm &> /dev/null; then
  NPM_VERSION=$(npm -v)
  print_status "npm instalado: $NPM_VERSION"
else
  print_error "npm no está instalado"
  exit 1
fi

# Check Git
echo ""
echo "3️⃣  Verificando Git..."
if command -v git &> /dev/null; then
  GIT_VERSION=$(git --version)
  print_status "$GIT_VERSION"
else
  print_error "Git no está instalado"
  exit 1
fi

# Install webOS CLI
echo ""
echo "4️⃣  Instalando webOS CLI globalmente..."
if npm list -g @webostv/webos-cli &> /dev/null; then
  print_status "webOS CLI ya está instalado"
  WEBOS_CLI_VERSION=$(webos-cli --version 2>/dev/null || echo "desconocida")
  echo "    Versión: $WEBOS_CLI_VERSION"
else
  print_warning "Instalando @webostv/webos-cli..."
  npm install -g @webostv/webos-cli --loglevel=warn
  if command -v webos-cli &> /dev/null; then
    print_status "webOS CLI instalado correctamente"
    webos-cli --version
  else
    print_error "Error al instalar webOS CLI"
    exit 1
  fi
fi

# Install webOS Emulator
echo ""
echo "5️⃣  Configurando webOS Emulator/Simulator..."
EMULATOR_PATH="$HOME/.webos-simulator"
if [ -d "$EMULATOR_PATH" ]; then
  print_status "Emulador webOS ya existe"
else
  print_warning "Para descargar el emulador (500MB+), ejecuta:"
  echo "    ${YELLOW}webos-cli simulator install${NC}"
  echo ""
fi

# Create project directory
echo ""
echo "6️⃣  Creando estructura de proyecto..."
PROJECT_DIR="webos-launcher"
if [ -d "$PROJECT_DIR" ]; then
  print_warning "Directorio '$PROJECT_DIR' ya existe"
else
  mkdir -p "$PROJECT_DIR"
  print_status "Directorio de proyecto creado: $PROJECT_DIR"
fi

# Initialize git repository
echo ""
echo "7️⃣  Inicializando repositorio Git..."
cd "$PROJECT_DIR"
if [ -d ".git" ]; then
  print_status "Repositorio Git ya existe"
else
  git init
  print_status "Repositorio Git inicializado"
  
  # Create .gitignore
  cat > .gitignore << 'EOF'
# Dependencies
node_modules/
package-lock.json
yarn.lock

# Build outputs
dist/
build/
*.zip

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*

# Environment
.env
.env.local
EOF
  print_status ".gitignore creado"
fi

# Create package.json
echo ""
echo "8️⃣  Creando package.json..."
cat > package.json << 'EOF'
{
  "name": "webos-custom-launcher",
  "version": "0.1.0",
  "description": "Custom Launcher for LG webOS 33 - Wii-style UI with optimized performance",
  "main": "index.js",
  "scripts": {
    "dev": "webos-cli run -i",
    "build": "npm run package",
    "package": "webos-cli package",
    "install-tv": "webos-cli install",
    "launch": "webos-cli launch",
    "debug": "webos-cli run",
    "emulator": "webos-cli emulator start",
    "lint": "eslint src/",
    "test": "jest"
  },
  "keywords": [
    "webos",
    "launcher",
    "tv",
    "lg"
  ],
  "author": "You",
  "license": "MIT",
  "dependencies": {
    "enyo": "^2.7.10"
  },
  "devDependencies": {
    "eslint": "^8.0.0",
    "jest": "^29.0.0",
    "webpack": "^5.0.0",
    "webpack-cli": "^5.0.0"
  }
}
EOF
print_status "package.json creado"

# Create project structure
echo ""
echo "9️⃣  Creando estructura de directorios..."
mkdir -p src/components
mkdir -p src/services
mkdir -p src/styles
mkdir -p src/assets
print_status "Estructura de directorios creada"

# Create webos-build.json (webOS configuration)
echo ""
echo "🔟 Creando configuración webOS..."
cat > webos-build.json << 'EOF'
{
  "id": "com.webos.app.customlauncher",
  "version": "0.1.0",
  "type": "web",
  "main": "index.html",
  "icon": "icon.png",
  "title": "Custom Launcher",
  "requiredPermissions": [
    "luna://com.webos.service.launcher/launch",
    "luna://com.webos.service.launcher/getAppList",
    "luna://com.webos.service.power/powerOff"
  ],
  "appDescription": "Faster launcher with Wii-style interface for webOS 33"
}
EOF
print_status "webos-build.json creado"

# Create basic HTML entry point
echo ""
echo "1️⃣1️⃣  Creando index.html base..."
cat > src/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=1920, height=1080, user-scalable=no">
  <title>WebOS Custom Launcher</title>
  <link rel="stylesheet" href="styles/theme.css">
</head>
<body>
  <div id="app-container">
    <h1>🚀 WebOS Custom Launcher</h1>
    <p>Initializing...</p>
  </div>
  <script src="js/app.js"></script>
</body>
</html>
EOF
print_status "index.html creado"

# Create basic CSS
echo ""
echo "1️⃣2️⃣  Creando estilos base..."
cat > src/styles/theme.css << 'EOF'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

#app-container {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: white;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
  z-index: 1;
}

h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  animation: fadeIn 0.5s ease-in;
}

p {
  font-size: 1.5rem;
  opacity: 0.8;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Optimizaciones para TV */
body {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Desabilitar focus visual por defecto (controles remotos no los usan) */
*:focus {
  outline: none;
}

/* Enfoque personalizado para navegación con dpad */
.focused {
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
}
EOF
print_status "theme.css creado"

# Create basic JavaScript
echo ""
echo "1️⃣3️⃣  Creando app.js base..."
cat > src/js/app.js << 'EOF'
// WebOS Custom Launcher - Main App

console.log("🚀 WebOS Custom Launcher Starting...");

// Detect webOS
function detectWebOS() {
  if (typeof webOS !== 'undefined') {
    console.log("✓ webOS environment detected");
    return true;
  }
  console.warn("⚠ Not running on webOS (development/emulator?)");
  return false;
}

// Initialize app
document.addEventListener('DOMContentLoaded', function() {
  console.log("✓ DOM loaded");
  
  const isWebOS = detectWebOS();
  
  const container = document.getElementById('app-container');
  container.innerHTML = `
    <h1>🚀 WebOS Custom Launcher</h1>
    <p>${isWebOS ? '✓ Running on webOS' : '⚠ Running on development mode'}</p>
    <p style="margin-top: 2rem; font-size: 1rem; opacity: 0.6;">
      Phase 1: Setup Complete ✓<br>
      Phase 2: Coming soon...
    </p>
  `;
});

// Handle remote control (if on webOS)
document.addEventListener('keydown', function(e) {
  console.log("Key pressed:", e.keyCode);
  
  // webOS remote key codes
  switch(e.keyCode) {
    case 37: // LEFT
      console.log("← Left");
      break;
    case 39: // RIGHT
      console.log("→ Right");
      break;
    case 38: // UP
      console.log("↑ Up");
      break;
    case 40: // DOWN
      console.log("↓ Down");
      break;
    case 13: // ENTER/OK
      console.log("⭕ OK");
      break;
    case 10252: // BACK
      console.log("⬅ Back");
      break;
  }
});

EOF
print_status "app.js creado"

# Create README
echo ""
echo "1️⃣4️⃣  Creando README..."
cat > README.md << 'EOF'
# WebOS Custom Launcher

Faster, fun Wii-style launcher for LG webOS 33 TVs.

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Run on Emulator
```bash
npm run emulator  # Start webOS emulator
npm run dev       # Deploy and run
```

### 3. Run on Real TV
First, enable Developer Mode on your LG TV and configure the IP:

```bash
webos-cli device add
# Enter TV IP when prompted
npm run install-tv
npm run launch
```

## Project Structure
```
src/
  ├── components/      # Enyo components
  ├── services/        # Luna Service wrappers
  ├── styles/          # CSS (TV-optimized)
  └── assets/          # Icons, fonts, etc.
```

## Development

### Build
```bash
npm run build
```

### Lint
```bash
npm run lint
```

### Debug
Connect to TV via SSH:
```bash
ssh -p 9922 root@<TV_IP>
```

## Resources
- [webOS Developer Portal](https://webostv.developer.lge.com/)
- [Enyo Framework](https://enyo.com/)
- [Luna Service API](https://webostv.developer.lge.com/develop/references/luna-service-api/)

## License
MIT
EOF
print_status "README.md creado"

# Summary
echo ""
echo "================================"
echo -e "${GREEN}✓ Setup Completo!${NC}"
echo "================================"
echo ""
echo "📁 Proyecto creado en: $PROJECT_DIR/"
echo ""
echo "🎯 Próximos pasos:"
echo ""
echo "1️⃣  Instalar emulador webOS (si no lo tienes):"
echo "    ${YELLOW}webos-cli simulator install${NC}"
echo ""
echo "2️⃣  Acceder al directorio del proyecto:"
echo "    ${YELLOW}cd $PROJECT_DIR${NC}"
echo ""
echo "3️⃣  (IMPORTANTE) Activar Developer Mode en tu TV LG:"
echo "    Settings → Channels → Developer Channel → Enable SSH"
echo ""
echo "4️⃣  Agregar dispositivo TV:"
echo "    ${YELLOW}webos-cli device add${NC}"
echo "    (Ingresa la IP de tu TV cuando se pida)"
echo ""
echo "5️⃣  Ejecutar en emulador:"
echo "    ${YELLOW}npm run dev${NC}"
echo ""
echo "6️⃣  O instalar en TV real:"
echo "    ${YELLOW}npm run install-tv && npm run launch${NC}"
echo ""
echo "📚 Documentación:"
echo "   - Lee FASE1_INVESTIGACION.md para detalles técnicos"
echo "   - Lee PLAN.md para el plan completo del proyecto"
echo ""

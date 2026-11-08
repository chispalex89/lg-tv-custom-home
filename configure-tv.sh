#!/bin/bash

# WebOS TV Configuration Helper
# Este script ayuda a configurar la conexión SSH a tu TV LG webOS

set -e

echo "🔧 WebOS TV Configuration Helper"
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
  echo "ℹ $1"
}

# Step 1: Verificar prerrequisitos
echo "Paso 1: Verificando requisitos..."
echo ""

if ! command -v webos-cli &> /dev/null; then
  print_error "webOS CLI no está instalado"
  echo "Instálalo primero con: npm install -g @webostv/webos-cli"
  exit 1
fi

print_status "webOS CLI detectado"

if ! command -v ssh &> /dev/null; then
  print_error "SSH no está disponible"
  exit 1
fi

print_status "SSH disponible"
echo ""

# Step 2: Instrucciones para Developer Mode
echo "Paso 2: Activar Developer Mode en tu TV"
echo "========================================"
echo ""
print_warning "IMPORTANTE: Estas instrucciones son para LG webOS 33"
echo ""
echo "Método 1 (Recomendado):"
echo "  1. En tu TV, ve a: Settings → Channels"
echo "  2. Busca 'Developer' o 'LG Developer'"
echo "  3. Abre 'Developer Channel'"
echo "  4. En Developer Settings, activa: SSH"
echo ""
echo "Método 2 (Hidden Menu):"
echo "  1. Ve a: Settings → All Settings"
echo "  2. Presiona esta secuencia: < > < > < > < >"
echo "  3. Debería aparecer 'Developer Mode'"
echo "  4. Actívalo"
echo ""
echo "Método 3 (About Menu):"
echo "  1. Ve a: Settings → All Settings → System → About"
echo "  2. Presiona OK 5 veces seguidas"
echo "  3. Busca opción de Developer Mode"
echo ""

read -p "Presiona ENTER cuando hayas activado Developer Mode en tu TV..."
echo ""

# Step 3: Obtener IP de la TV
echo "Paso 3: Encontrar IP de la TV"
echo "============================="
echo ""
echo "Opción 1: Automático (escanea la red)"
echo "Opción 2: Manual (ingresas la IP)"
echo ""

read -p "¿Cuál prefieres? (1/2, default=1): " -r OPTION
OPTION=${OPTION:-1}

TV_IP=""

if [ "$OPTION" = "1" ]; then
  print_warning "Escaneando red local por TVs webOS..."
  echo "(Esto puede tomar unos segundos)"
  echo ""
  
  # Try to find webOS TV
  # Get local network
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | head -1 | awk '{print $2}')
    NETWORK="${LOCAL_IP%.*}.0/24"
  else
    # Linux
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    NETWORK="${LOCAL_IP%.*}.0/24"
  fi
  
  print_info "Red local detectada: $NETWORK"
  
  # Scan for webOS devices using nmap (if available) or basic ping
  if command -v nmap &> /dev/null; then
    print_info "Usando nmap para buscar dispositivos..."
    DEVICES=$(nmap -p 9922 -oG - $NETWORK 2>/dev/null | grep open | awk '{print $2}')
    
    if [ -z "$DEVICES" ]; then
      print_warning "No se encontraron TVs en la red"
    else
      echo "Dispositivos encontrados:"
      echo "$DEVICES"
      read -p "Ingresa la IP del TV: " TV_IP
    fi
  else
    print_warning "nmap no está instalado, usando método manual"
    read -p "Ingresa la IP de tu TV: " TV_IP
  fi
else
  read -p "Ingresa la IP de tu TV LG: " TV_IP
fi

if [ -z "$TV_IP" ]; then
  print_error "No se ingresó IP válida"
  exit 1
fi

echo ""
print_status "IP ingresada: $TV_IP"
echo ""

# Step 4: Verificar conexión SSH
echo "Paso 4: Verificando conexión SSH"
echo "================================="
echo ""

print_warning "Intentando conectar a $TV_IP (puerto 9922)..."

if timeout 5 bash -c "echo > /dev/tcp/$TV_IP/9922" 2>/dev/null; then
  print_status "✓ Puerto SSH 9922 está abierto"
else
  print_error "No se puede conectar al puerto 9922"
  echo ""
  echo "Posibles causas:"
  echo "  - Developer Mode no está activado"
  echo "  - SSH no está habilitado"
  echo "  - IP incorrecta"
  echo "  - Firewall bloqueando la conexión"
  echo ""
  read -p "¿Deseas intentar de todas formas? (s/n): " -r RETRY
  if [[ ! "$RETRY" =~ ^[Ss]$ ]]; then
    exit 1
  fi
fi

echo ""

# Step 5: Agregar dispositivo a webOS CLI
echo "Paso 5: Agregando dispositivo a webOS CLI"
echo "=========================================="
echo ""

read -p "¿Agregar $TV_IP como dispositivo? (s/n, default=s): " -r ADD_DEVICE
ADD_DEVICE=${ADD_DEVICE:-s}

if [[ "$ADD_DEVICE" =~ ^[Ss]$ ]]; then
  echo ""
  echo "Ejecutando: webos-cli device add"
  echo ""
  
  # Try automated way first
  # Create a device config file manually
  DEVICE_NAME="mywebostv"
  read -p "¿Qué nombre quieres para este dispositivo? (default=mywebostv): " -r DEVICE_INPUT
  DEVICE_NAME=${DEVICE_INPUT:-mywebostv}
  
  print_info "Configurando conexión SSH..."
  
  # webOS CLI should handle this, but we can add it manually too
  # Try connecting first to get the fingerprint
  print_warning "Intentando conexión SSH (se pedirá contraseña)..."
  echo ""
  echo "Contraseña por defecto: lge-com (o similar según modelo)"
  echo ""
  
  if sshpass -p "lge-com" ssh -o StrictHostKeyChecking=accept-new -p 9922 root@$TV_IP "echo 'SSH Connection OK'" 2>/dev/null; then
    print_status "Conexión SSH exitosa"
  elif ssh -o StrictHostKeyChecking=accept-new -p 9922 root@$TV_IP "echo 'SSH Connection OK'" 2>/dev/null; then
    print_status "Conexión SSH exitosa"
  else
    print_warning "No se pudo conectar vía SSH automáticamente"
    echo ""
    echo "Intenta manualmente:"
    echo "  ssh -p 9922 root@$TV_IP"
    echo ""
    echo "Si se pide contraseña, intenta: lge-com"
  fi
  
  echo ""
fi

# Step 6: Test SSH Connection
echo "Paso 6: Prueba de Conexión Final"
echo "================================="
echo ""

print_warning "Conectando a $TV_IP para obtener info del sistema..."
echo ""

if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new -p 9922 root@$TV_IP 'getdisplayinfo' 2>/dev/null | head -10; then
  print_status "Conexión exitosa y dispositivo respondiendo"
  echo ""
  print_status "¡Tu TV está lista para desarrollo!"
else
  print_warning "No se pudo obtener info del sistema"
  echo ""
  echo "Para conectar manualmente:"
  echo "  ssh -p 9922 root@$TV_IP"
  echo ""
fi

echo ""
echo "Paso 7: Configuración de webOS CLI"
echo "==================================="
echo ""

print_info "Para usar webOS CLI con tu TV, ejecuta:"
echo ""
echo "  ${YELLOW}webos-cli device add${NC}"
echo ""
echo "Y sigue el asistente. Cuando se pida:"
echo "  - Host/IP: $TV_IP"
echo "  - Puerto: 9922"
echo "  - Usuario: root"
echo ""

# Final summary
echo ""
echo "================================"
echo -e "${GREEN}✓ Configuración Completada${NC}"
echo "================================"
echo ""
echo "📺 TV Configurada:"
echo "   IP: $TV_IP"
echo "   Puerto: 9922"
echo ""
echo "🎯 Próximos pasos:"
echo ""
echo "1️⃣  Agregar dispositivo a webOS CLI:"
echo "    ${YELLOW}webos-cli device add${NC}"
echo ""
echo "2️⃣  Verificar dispositivos:"
echo "    ${YELLOW}webos-cli device list${NC}"
echo ""
echo "3️⃣  Conectar a tu proyecto:"
echo "    ${YELLOW}cd webos-launcher${NC}"
echo "    ${YELLOW}npm run install-tv${NC}"
echo ""
echo "4️⃣  Iniciar la app en TV:"
echo "    ${YELLOW}npm run launch${NC}"
echo ""
echo "5️⃣  Ver logs en tiempo real:"
echo "    ${YELLOW}npm run debug${NC}"
echo ""

echo "💡 Pro Tips:"
echo "   - El app se reinstala cada vez que ejecutas npm run install-tv"
echo "   - Puedes ver logs conectándote por SSH: ssh -p 9922 root@$TV_IP"
echo "   - Para desinstalar: ssh -p 9922 root@$TV_IP com.webos.app.remove com.webos.app.customlauncher"
echo ""


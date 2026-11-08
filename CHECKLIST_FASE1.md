# Checklist Ejecutable - Fase 1: Investigación & Setup

## ✅ Checklist de Instalación

### A. Preparación del PC (30 minutos)

- [ ] **Node.js v14+**
  - Verificar: `node --version`
  - Si falta: Descargar desde https://nodejs.org/
  - Recomendado: LTS (18.x o 20.x)

- [ ] **npm/yarn**
  - Verificar: `npm --version`
  - Viene con Node.js generalmente

- [ ] **Git**
  - Verificar: `git --version`
  - Si falta: https://git-scm.com/

- [ ] **SSH Client**
  - macOS/Linux: Incluido por defecto
  - Windows: Usar WSL2 o Git Bash

### B. Instalación de Herramientas webOS (15 minutos)

- [ ] **webOS CLI**
  ```bash
  npm install -g @webostv/webos-cli
  webos-cli --version
  ```

- [ ] **webOS Studio (VS Code Extension)**
  1. Abrir VS Code
  2. Extensions (Ctrl+Shift+X)
  3. Buscar "webOS Studio"
  4. Instalar extensión oficial de LG

- [ ] **(Opcional) webOS Emulator**
  ```bash
  webos-cli simulator install
  # Esto descargará ~500MB
  ```

### C. Configuración de la TV (20-30 minutos)

- [ ] **Activar Developer Mode**
  - Opción 1: Settings → Channels → Developer Channel
  - Opción 2: Settings → Hidden Menu (ver FASE1_INVESTIGACION.md)

- [ ] **Habilitar SSH**
  - En Developer Settings: SSH = ON
  - Anotar IP de la TV

- [ ] **Conocer la Contraseña SSH**
  - Por defecto: "lge-com" o similar
  - Verificar en documentación del modelo

### D. Ejecutar Scripts de Setup (10 minutos)

- [ ] **Script 1: Setup del Proyecto**
  ```bash
  cd ~/tu_carpeta_de_desarrollo
  bash setup.sh
  # Esto creará la carpeta webos-launcher con estructura base
  ```

- [ ] **Script 2: Configurar Conexión TV**
  ```bash
  bash configure-tv.sh
  # Seguir instrucciones interactivas
  # Ingresar IP de la TV
  # Verifica conexión SSH
  ```

### E. Verificación Final (10 minutos)

- [ ] **Verificar Proyecto**
  ```bash
  cd webos-launcher
  ls -la
  # Debe existir: package.json, webos-build.json, src/
  ```

- [ ] **Verificar Conexión SSH a TV**
  ```bash
  ssh -p 9922 root@<TU_IP_TV>
  # Si pide contraseña: lge-com
  # Salir: exit
  ```

- [ ] **Agregar TV a webOS CLI**
  ```bash
  webos-cli device add
  # Ingresar IP cuando se pida
  webos-cli device list
  # Debe aparecer tu TV
  ```

---

## 📋 Checklist de Aprendizaje (Opcional pero Recomendado)

- [ ] Leer: FASE1_INVESTIGACION.md (15 minutos)
  - Entender arquitectura de webOS
  - Conocer Luna Service API
  - Revisar opciones de frameworks

- [ ] Leer: PLAN.md (10 minutos)
  - Entender objetivos del proyecto
  - Ver timeline de 7 fases
  - Conocer métricas de éxito

- [ ] Explorar: Documentación webOS Official
  - https://webostv.developer.lge.com/
  - Focus en: Getting Started, APIs, Samples

- [ ] Explorar: Enyo Framework (si aplica)
  - https://enyo.com/docs/
  - Revisar ejemplos básicos

---

## 🚀 Primeras Pruebas

### Test 1: Crear App Hello World (30 minutos)

```bash
cd webos-launcher
npm install

# Modificar src/index.html con tu contenido

# Empaquetar
npm run build

# Instalar en TV
npm run install-tv

# Lanzar
npm run launch
```

### Test 2: Ver Logs en Tiempo Real (10 minutos)

```bash
# Terminal 1: Ver logs
npm run debug

# Terminal 2: Ejecutar comando en TV
ssh -p 9922 root@<TU_IP_TV> tail -f /var/log/messages
```

### Test 3: Probar Entrada de Control Remoto (10 minutos)

Presionar botones en control remoto mientras app está abierta:
- [ ] Flechas (izquierda/derecha/arriba/abajo)
- [ ] OK/Seleccionar
- [ ] Back/Return
- [ ] Menu

Verificar en logs que los key events aparecen

---

## 🎯 Entregables de Fase 1

Al completar todo esto, debes tener:

- [ ] ✅ Proyecto inicializado con estructura base
- [ ] ✅ webOS CLI instalado y funcionando
- [ ] ✅ VS Code con webOS Studio extension
- [ ] ✅ TV LG con Developer Mode + SSH habilitado
- [ ] ✅ Conexión SSH verificada desde PC
- [ ] ✅ TV agregada a webOS CLI
- [ ] ✅ App "Hello World" deployable
- [ ] ✅ Documentación investigativa completada

**Tiempo total estimado**: 2-3 horas (dependiendo de velocidad de internet)

---

## ⚠️ Troubleshooting Común

### "webOS CLI no se encuentra"
```bash
# Re-instalar
npm uninstall -g @webostv/webos-cli
npm install -g @webostv/webos-cli
# Reiniciar terminal
```

### "No puedo conectar a la TV por SSH"
1. Verificar IP correcta: Settings → About → IP Address
2. Verificar SSH está habilitado: Developer Settings → SSH ON
3. Reiniciar TV: Apagar y encender
4. Probar con contraseña "lge-com"

### "Contraseña SSH incorrecta"
- Valor por defecto: `lge-com`
- Algunos modelos: `weboslive` o vacío
- Revisar documentación del modelo específico

### "npm install falla"
```bash
# Limpiar cache
npm cache clean --force

# Reintentar
npm install
```

### "webos-cli device add no funciona"
```bash
# Intentar manual
mkdir -p ~/.webos-cli-iot/devices
# Agregar configuración manual si es necesario
```

---

## 📞 Recursos de Ayuda

- **Official**: https://webostv.developer.lge.com/
- **Forum**: Buscar en webOS Developer Community
- **Stack Overflow**: Tag `webos`
- **GitHub**: https://github.com/webosose/

---

## 🎓 Siguientes Pasos (Fase 2)

Una vez completada Fase 1:

1. Estudiar Enyo Framework en profundidad
2. Crear componentes base de Launcher
3. Implementar gestor de aplicaciones
4. Diseñar interfaz Wii-style

**Estimado para Fase 2**: 2 semanas

---

**Última actualización**: 2026-11-07
**Estado**: 📋 Lista


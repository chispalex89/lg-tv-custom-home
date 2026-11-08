# Recursos & Guía de Referencia Rápida

## 🔗 Links Importantes

### Documentación Oficial
| Recurso | URL |
|---------|-----|
| webOS Developer Portal | https://webostv.developer.lge.com/ |
| webOS CLI Docs | https://webostv.developer.lge.com/develop/tools/webos-cli/ |
| webOS TV App Development | https://webostv.developer.lge.com/develop/app-developer-guide/ |
| Luna Service API Ref | https://webostv.developer.lge.com/develop/references/luna-service-api/ |
| webOS.JS Library | https://webostv.developer.lge.com/develop/references/webos-service/ |

### Frameworks
| Framework | URL | Notas |
|-----------|-----|-------|
| Enyo Framework | https://enyo.com/docs/ | Framework oficial webOS |
| Enact (Enyo 2.7) | https://enact.io/ | Evolución moderna de Enyo |
| Flutter para webOS | https://github.com/flutter-webos | Soporte nuevo |

### Open Source
| Proyecto | URL | Descripción |
|----------|-----|-------------|
| webOS OSE | https://github.com/webosose | Open Source Edition |
| Samples | https://github.com/webosose/samples | Código de referencia |
| Enact Browser | https://github.com/webosose/com.webos.app.enactbrowser | App de referencia |

---

## 💻 Comandos Útiles Rápidos

### webOS CLI Básicos

```bash
# Verificar versión
webos-cli --version

# Ver ayuda
webos-cli help

# Gestión de dispositivos
webos-cli device add           # Agregar TV
webos-cli device list          # Listar TVs configuradas
webos-cli device info          # Info del dispositivo
webos-cli device remove <name> # Quitar TV

# Emulador
webos-cli simulator install    # Descargar emulador
webos-cli simulator start      # Iniciar emulador
webos-cli simulator stop       # Detener emulador

# App development
webos-cli package              # Empaquetar app (crea .ipk)
webos-cli install              # Instalar en TV/emulador
webos-cli launch               # Lanzar app
webos-cli run                  # Install + launch
webos-cli debug                # Modo debug (logs en vivo)
webos-cli remove               # Desinstalar app
```

### SSH a la TV

```bash
# Conexión básica
ssh -p 9922 root@<IP_TV>

# Con password sin prompta (requiere sshpass)
sshpass -p "lge-com" ssh -p 9922 root@<IP_TV>

# Ejecutar comando remoto
ssh -p 9922 root@<IP_TV> "getdisplayinfo"

# Ver logs del sistema
ssh -p 9922 root@<IP_TV> "tail -f /var/log/messages"

# Ver procesos
ssh -p 9922 root@<IP_TV> "ps aux"

# Desinstalar app
ssh -p 9922 root@<IP_TV> "luna-send -n 1 'luna://com.webos.service.launcher/close' \
  '{\"id\":\"com.webos.app.customlauncher\"}'"
```

### npm en Proyecto

```bash
# Instalar dependencias
npm install

# Actualizar dependencias
npm update

# Ver versión de paquete
npm list enyo

# Limpiar
npm cache clean --force

# Auditar seguridad
npm audit

# Auditar y auto-fix
npm audit fix
```

---

## 🔌 Luna Service API - Ejemplos Prácticos

### 1. Lanzar una Aplicación

```javascript
// Service: luna://com.webos.service.launcher
// Method: launch

var request = webOS.service.request("luna://com.webos.service.launcher/launch", {
  parameters: {
    id: "youtube.leanback.v4"  // YouTube
  },
  onSuccess: function(response) {
    console.log("App launched:", response);
  },
  onFailure: function(error) {
    console.error("Launch failed:", error);
  }
});
```

### 2. Obtener Lista de Aplicaciones Instaladas

```javascript
var request = webOS.service.request("luna://com.webos.service.launcher/getAppList", {
  parameters: {},
  onSuccess: function(response) {
    console.log("Apps installed:", response.apps);
    // response.apps es un array de apps
    response.apps.forEach(function(app) {
      console.log(app.title + " (" + app.id + ")");
    });
  },
  onFailure: function(error) {
    console.error("Get apps failed:", error);
  }
});
```

### 3. Control de Volumen

```javascript
// Obtener volumen actual
webOS.service.request("luna://com.webos.service.audio/getVolume", {
  parameters: {},
  onSuccess: function(response) {
    console.log("Volume:", response.volume);
  }
});

// Establecer volumen
webOS.service.request("luna://com.webos.service.audio/setVolume", {
  parameters: {
    volume: 50  // 0-100
  },
  onSuccess: function(response) {
    console.log("Volume set to:", response.volume);
  }
});
```

### 4. Información del Sistema

```javascript
webOS.service.request("luna://com.webos.service.devinfo/getInfo", {
  parameters: {},
  onSuccess: function(response) {
    console.log("System Info:", response);
    // Contiene: version, modelName, deviceId, etc.
  }
});
```

### 5. Cerrar Aplicación

```javascript
webOS.service.request("luna://com.webos.service.launcher/close", {
  parameters: {
    id: "youtube.leanback.v4"  // ID de app a cerrar
  },
  onSuccess: function(response) {
    console.log("App closed");
  }
});
```

---

## 🎮 Códigos de Botones Remote Control

Códigos de tecla para manejo de input en webOS:

| Botón | keyCode | keyName |
|-------|---------|---------|
| LEFT | 37 | ArrowLeft |
| RIGHT | 39 | ArrowRight |
| UP | 38 | ArrowUp |
| DOWN | 40 | ArrowDown |
| OK/SELECT | 13 | Enter |
| BACK/EXIT | 10252 | Exit |
| MENU/HOME | 10133 | Home |
| VOL UP | 10140 | VolumeUp |
| VOL DOWN | 10141 | VolumeDown |
| MUTE | 10142 | VolumeMute |
| 0-9 | 48-57 | Digit0-Digit9 |

### Capturar Teclas en JavaScript

```javascript
document.addEventListener('keydown', function(e) {
  console.log("Key Code:", e.keyCode);
  console.log("Key:", e.key);
  
  switch(e.keyCode) {
    case 37: // LEFT
      handleLeft();
      break;
    case 39: // RIGHT
      handleRight();
      break;
    case 38: // UP
      handleUp();
      break;
    case 40: // DOWN
      handleDown();
      break;
    case 13: // OK
      handleSelect();
      break;
    case 10252: // BACK
      handleBack();
      break;
  }
});
```

---

## 🛠️ Estructura Típica de App webOS

```
my-webos-app/
├── appinfo.json              # Metadatos app
├── icon.png                  # Icono (150x150)
├── index.html                # HTML principal
├── js/
│   └── app.js               # JavaScript principal
├── css/
│   └── style.css            # Estilos
├── resources/               # Recursos (fonts, imágenes, etc)
└── webos-build.json         # Config webOS CLI (NO COMMITEAR)
```

### Mínimo appinfo.json

```json
{
  "id": "com.example.myapp",
  "version": "1.0.0",
  "vendor": "My Company",
  "type": "web",
  "main": "index.html",
  "title": "My App Title",
  "appDescription": "App description here",
  "icon": "icon.png"
}
```

---

## 📊 Performance Tips para TV

### ✅ DO (Hacer)

- ✅ Usar CSS transforms (más rápido que cambiar position/size)
- ✅ Implementar virtualización para listas largas
- ✅ Usar requestAnimationFrame para animaciones
- ✅ Lazy load imágenes
- ✅ Minify CSS/JS
- ✅ Usar event delegation
- ✅ Cachear queries del DOM
- ✅ Usar worker threads para procesamiento pesado

### ❌ DON'T (No Hacer)

- ❌ Animaciones complejas con muchos elementos
- ❌ Cambios frecuentes de DOM
- ❌ Polyfills innecesarios
- ❌ Libs pesadas si no las necesitas
- ❌ Loops infinitos
- ❌ Acceso frecuente a localStorage sin cache
- ❌ Multiple reflows/repaints en loop
- ❌ setTimeout/setInterval sin cleanup

### Medición de Performance

```javascript
// Medir tiempo de operación
const start = performance.now();
// ... operación
const end = performance.now();
console.log("Tiempo:", (end - start) + "ms");

// Observer de cambios de performance
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    console.log("Performance entry:", entry.name, entry.duration);
  }
});

observer.observe({ entryTypes: ["measure", "navigation"] });
```

---

## 🐛 Debugging Tips

### 1. Logs en Web Inspector

```javascript
// webOS proporciona console nativa
console.log("Normal log");
console.warn("Warning");
console.error("Error");
console.table(arrayData);
```

### 2. Ver Logs Remotamente

```bash
# En terminal, conectarse a TV
ssh -p 9922 root@<IP_TV>

# Ver logs en tiempo real
tail -f /var/log/messages

# Buscar logs de tu app
grep "com.webos.app.customlauncher" /var/log/messages

# Salir
exit
```

### 3. Web Inspector en webOS

Algunas apps webOS permiten debugger por puerto:

```bash
# Si webOS expone chrome devtools
# (no todas las versiones lo hacen)
# Acceder a: http://TV_IP:9222
```

### 4. Debugging en Emulador

```bash
# El emulador sí expone devtools
# Usar webOS Studio en VS Code para debugging visual
```

---

## 🚨 Errores Comunes y Soluciones

| Error | Causa | Solución |
|-------|-------|----------|
| `EACCES permission denied` | Falta permisos en SSH | `sudo npm install -g` |
| `Cannot find module 'enyo'` | npm dependencies no instaladas | `npm install` |
| `App not found on device` | App no está instalada | `npm run install-tv` |
| `Connection refused: 9922` | SSH no habilitado | Activar en Developer Settings |
| `Permission denied (publickey)` | Contraseña incorrecta | Intentar "lge-com" |
| `Device not found` | IP incorrecta | Verificar con `Settings → About` |
| `Luna Service error` | Servicio no disponible | Revisar nombre exacto del servicio |
| `Memory limit exceeded` | App usa demasiada RAM | Optimizar uso de memoria |

---

## 📚 Estructura de Enyo (si lo usas)

```javascript
// Componente Enyo básico
enyo.kind({
  name: "MyComponent",
  
  // Propiedades
  properties: {
    myProp: "default value"
  },
  
  // Componentes internos (como JSX)
  components: [
    {kind: "onyx.Button", content: "Click me", ontap: "handleTap"}
  ],
  
  // Handlers
  handleTap: function() {
    enyo.log("Button tapped!");
  }
});

// Crear instancia
var myComp = new MyComponent().render();
```

---

**Versión**: 1.0
**Última actualización**: 2026-11-07


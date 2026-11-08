# Fase 1: Investigación & Setup - WebOS Custom Launcher
**Estado**: 🔄 En Progreso | **Fecha**: 2026-11-07

---

## 📊 Hallazgos de Investigación

### webOS SDK & Herramientas Oficiales

#### ✅ Disponible para Desarrollo
1. **webOS Studio** (VS Code Extension)
   - Extensión oficial para desarrollo en webOS
   - Integración con webOS CLI
   - Soporte para debugging remoto

2. **webOS TV Simulator**
   - Emulador para testing sin TV física
   - Integración con CLI y Studio
   - Soporte para control remoto virtual

3. **APIs & Librerías Disponibles**
   - **Web APIs**: Estándares web (HTML5, CSS3, JavaScript)
   - **webOS.JS Library**: Acceso a características específicas de TV
   - **Luna Service API**: Interfaz con servicios del sistema webOS
   - **Flutter Support**: (Nuevo, desde 2026)

### webOS Open Source Edition (OSE)
- Repositorio público: `https://github.com/webosose`
- Contiene samples de código JavaScript
- Apps de referencia (Enact Browser, etc.)
- Herramientas para Luna System Bus

---

## 🏗️ Arquitectura de webOS 33

### Componentes Clave
```
┌─────────────────────────────────────┐
│       Application Layer              │
│  (Tu Launcher Custom + otras apps)   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    webOS Runtime Environment         │
│  - Enyo Framework                    │
│  - Node.js Engine                    │
│  - Luna Service Bus                  │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    System Services (Luna Services)   │
│  - App Manager                       │
│  - Window Manager                    │
│  - Network Manager                   │
│  - Settings Manager                  │
│  - (otros servicios del sistema)     │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Linux Kernel                 │
└─────────────────────────────────────┘
```

### Acceso a Servicios
- **Luna Service Bus**: IPC para comunicación entre apps/servicios
- **webOS.service**: API para llamar servicios del sistema
- Ejemplos: lanzar apps, obtener info del sistema, configurar ajustes

---

## 🎯 Opciones de Frameworks

### Opción 1: Enyo Framework (RECOMENDADO)
**Ventajas**:
- ✅ Framework oficial de webOS
- ✅ Optimizado para TVs (bajo overhead)
- ✅ Soporte nativo para controles remotos
- ✅ MVC arquitectura clara
- ✅ Comunidad webOS

**Desventajas**:
- ❌ Menos recursos online que frameworks genéricos
- ❌ Learning curve más empinada

**Mejor para**: Experiencia nativa optimizada

### Opción 2: Node.js + Express (ALTERNATIVA)
**Ventajas**:
- ✅ Stack moderno y familiar
- ✅ Más fácil de debugguear
- ✅ Ecosistema NPM enorme
- ✅ Mejor performance potencialmente

**Desventajas**:
- ❌ Menos optimizado para interfaz TV
- ❌ Overhead innecesario

**Mejor para**: Backend de servicios

### Opción 3: Flutter (NUEVA)
**Ventajas**:
- ✅ Soporte oficial reciente
- ✅ Performance superior
- ✅ UI framework moderno

**Desventajas**:
- ❌ Documentación de webOS aún limitada
- ❌ Comunidad webOS-Flutter pequeña

**Mejor para**: Interfaz de alto rendimiento (futuro)

**RECOMENDACIÓN**: Usar **Enyo Framework** para MVP (experiencia nativa) + **Node.js** para servicios backend si aplica

---

## 🔧 Configuración de Entorno

### Requisitos del Sistema (PC Desarrollo)
- **OS**: macOS, Linux o Windows
- **Node.js**: 14.x o superior (webOS 33 compatible)
- **npm/yarn**: 6.x o superior
- **Git**: Para control de versiones

### Instalación de webOS SDK

#### 1. Instalar webOS CLI
```bash
npm install -g @webostv/webos-cli
# o si usas yarn:
yarn global add @webostv/webos-cli
```

#### 2. Instalar webOS Studio (VS Code)
- Abrir VS Code
- Extensions Marketplace
- Buscar "webOS Studio"
- Instalar extensión oficial de LG

#### 3. Descargar webOS TV Simulator
```bash
# Verificar versión instalada
webos-cli --version

# Instalar simulador
webos-cli simulator install
```

### Requisitos TV LG (webOS 33)

#### Activar Developer Mode
1. **Vía Oculto Menu**:
   - Ir a Settings → All Settings
   - Presionar secuencia: `<` `>` `<` `>` `<` `>` `<` `>` (8 veces alternado)
   - Debería aparecer "Developer Mode" en menu

2. **Vía Servicio**:
   - Settings → About → Version → Presionar OK 5 veces
   - Habilitar "Developer Mode"

3. **Habilitar SSH**:
   - Ir a Channels → LG Channels
   - Buscar "Developer Channel"
   - En Developer Settings → SSH: ON

#### Obtener IP & Contraseña SSH
- Settings → All Settings → System → About
- Anotar **IP Address** del TV
- Contraseña SSH por defecto: varía según modelo (generalmente `lge-com`)

#### Conectar SSH desde PC
```bash
# Conexión SSH a la TV
ssh -p 9922 root@<TV-IP>

# Ejemplo:
ssh -p 9922 root@192.168.1.100
```

---

## 📝 Luna Service API - Lo Esencial

### Conceptos Clave
- **Luna Services**: Servicios del sistema expuestos via Luna Bus
- **Service ID**: Identificador del servicio (e.g., `com.webos.service.launcher`)
- **Method**: Método a llamar en el servicio
- **Parameters**: Argumentos JSON

### Ejemplos de Servicios Útiles
```javascript
// Lanzar una app
lunaSrv.call('luna://com.webos.service.launcher/launch', {
  id: 'youtube.leanback.v4'  // App ID
});

// Obtener lista de apps instaladas
lunaSrv.call('luna://com.webos.service.launcher/getAppList', {});

// Control de volumen
lunaSrv.call('luna://com.webos.service.audio/getVolume', {});

// Apagar TV
lunaSrv.call('luna://com.webos.service.power/powerOff', {});
```

### Cómo Acceder desde App Enyo
```javascript
// En componente Enyo
enyo.kind({
  name: "MyApp",
  components: [
    {kind: "webos.Service", service: "luna://com.webos.service.launcher",
      method: "getAppList", onResponse: "handleAppList"}
  ],
  handleAppList: function(inSender, inResponse) {
    // inResponse contiene apps instaladas
    enyo.log("Apps:", inResponse.apps);
  }
});
```

---

## 📊 Análisis de Input Delay Actual

### Problema Identificado
- webOS 33 tiene (~500ms) delay entre click y respuesta
- Causas potenciales:
  1. Animaciones pesadas en Home
  2. Polling lento de eventos
  3. Renderizado en main thread
  4. Servicios bloqueantes

### Soluciones en Nuestro Launcher
1. ✅ No usar animaciones complejas
2. ✅ Event listeners asincronos
3. ✅ Worker threads para procesamiento
4. ✅ Cache agresivo de datos
5. ✅ Precarga de apps

---

## 🚀 Próximos Pasos Inmediatos

### Hoy/Mañana
- [ ] Instalar Node.js 18+ en PC
- [ ] Instalar webOS CLI
- [ ] Instalar webOS Studio en VS Code
- [ ] Descargar webOS TV Simulator

### Esta semana
- [ ] Activar Developer Mode en TV
- [ ] Obtener acceso SSH a TV
- [ ] Crear proyecto "Hello World" en Enyo
- [ ] Deploy a simulador
- [ ] Deploy a TV real y verificar conexión

### Siguientes dos semanas
- [ ] Estudiar Enyo Framework en profundidad
- [ ] Diseñar estructura de directorios
- [ ] Crear componentes base (Launcher, AppManager, UITheme)
- [ ] Medir baseline de performance

---

## 📚 Recursos de Referencia

### Documentación Oficial
- [webOS Developer Portal](https://webostv.developer.lge.com/)
- [webOS CLI Documentation](https://webostv.developer.lge.com/develop/tools/using-cli/)
- [Enyo Framework Docs](https://enyo.com/docs/)
- [Luna Service API Reference](https://webostv.developer.lge.com/develop/references/luna-service-api/)

### Repositorios Útiles
- [webOS Open Source Edition](https://github.com/webosose)
- [Sample Apps](https://github.com/webosose/samples)
- [Enact Browser (Reference)](https://github.com/webosose/com.webos.app.enactbrowser)

### Comunidades
- [webOS Developer Forum](https://webostv.developer.lge.com/)
- Stack Overflow: tag `webos`
- Reddit: r/webOS

---

## ⚙️ Configuración Recomendada para Proyecto

```
webosx-launcher/
├── src/
│   ├── components/          # Componentes Enyo
│   │   ├── Launcher.js
│   │   ├── AppGrid.js
│   │   ├── TopBar.js
│   │   └── Settings.js
│   ├── services/            # Luna Services wrappers
│   │   ├── AppManager.js
│   │   └── SystemService.js
│   ├── styles/              # CSS optimizado
│   │   ├── theme.css
│   │   └── responsive.css
│   └── index.html
├── package.json
├── webos-build.json         # Configuración webOS
├── .eslintrc
└── README.md
```

---

**Estado Actual**: 📋 Documentación investigación completada
**Siguiente**: Instalación de herramientas en PC

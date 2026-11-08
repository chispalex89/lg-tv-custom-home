# 🚀 Guía de Inicio Rápido - WebOS Custom Launcher (Home Replacement)

**Tiempo total estimado**: 2-3 horas

---

## ⚠️ ANTES DE EMPEZAR: LEE LA GUÍA DE REVERT

**📖 [REVERT_GUIDE.md](REVERT_GUIDE.md)** - Cómo restaurar a original si es necesario

- ✅ Sistema de backup automático
- ✅ 3 opciones de revert (script, SSH, botón nuclear)
- ✅ No perderás datos
- ✅ 100% reversible

**Tiempo**: 5 minutos de lectura
**Valor**: Tranquilidad total

---

## 📌 Qué Haremos

Crear un **home replacement personalizado para tu TV LG webOS 33** que sea:
- ⚡ **Más rápido** (reducir input delay)
- 🎨 **Más divertido** (estilo Nintendo Wii)
- 📱 **Funcional** (acceso a apps de streaming)
- 🔒 **Seguro** (sin modificar ROM ni hardware)
- 🔄 **Reversible** (backup automático antes de cambios)

---

## ⚡ 5 Pasos para Comenzar

### PASO 1: Preparar PC (30 minutos)

```bash
# 1️⃣ Instalar Node.js 18+ (si no lo tienes)
# Descargar: https://nodejs.org/
node --version  # Verificar >= v14

# 2️⃣ Instalar webOS CLI
npm install -g @webostv/webos-cli
webos-cli --version

# 3️⃣ Instalar VS Code Extension (opcional pero recomendado)
# Abrir VS Code → Extensions → Buscar "webOS Studio" → Instalar
```

### PASO 2: Preparar TV LG (20 minutos)

```
En tu TV LG:
1. Ve a: Settings → Channels
2. Busca: Developer Channel (o presiona 5 veces en About)
3. Abre Developer Settings
4. Activa: SSH = ON
5. Anota: La IP de tu TV (Settings → About → IP Address)

⚠️ Contraseña SSH por defecto: "lge-com"
```

### PASO 3: Ejecutar Script de Setup (5 minutos)

```bash
# Descargar/copiar setup.sh
bash setup.sh

# Esto creará:
# ✓ Carpeta webos-launcher/
# ✓ Estructura de proyecto
# ✓ package.json
# ✓ HTML/CSS/JS base
```

### PASO 4: Configurar Conexión TV (10 minutos)

```bash
# Ejecutar script de configuración
bash configure-tv.sh

# Seguir instrucciones:
# 1. Ingresar IP de TV
# 2. Verificar conexión SSH
# 3. Agregar a webOS CLI
```

### PASO 5: Prueba Hello World (10 minutos)

```bash
cd webos-launcher
npm install                # Descargar dependencias
npm run build             # Empaquetar
npm run install-tv        # Instalar en TV
npm run launch            # Ejecutar

# Deberías ver la app en tu TV ✨
```

---

## 📁 Archivos Creados

Este proyecto incluye:

| Archivo | Descripción |
|---------|-------------|
| `PLAN.md` | Plan completo de 7 fases (12 semanas) |
| `FASE1_INVESTIGACION.md` | Investigación detallada de webOS |
| `CHECKLIST_FASE1.md` | Checklist paso a paso |
| `RECURSOS_REFERENCIA.md` | APIs, comandos, ejemplos código |
| `setup.sh` | Script automatizado de setup |
| `configure-tv.sh` | Script para configurar conexión TV |
| `webos-launcher/` | Carpeta del proyecto (creada por setup.sh) |

---

## 🎯 Próximos Pasos Después de Hoy

### Semana 1: Consolidar Setup
- [ ] Completar CHECKLIST_FASE1.md
- [ ] Lograr Hello World funcionando en TV
- [ ] Familiarizarse con webOS CLI
- [ ] Conectar por SSH y ver logs

### Semana 2-3: Aprender Frameworks
- [ ] Estudiar Enyo Framework (framework oficial)
- [ ] Crear componentes base
- [ ] Entender Luna Service API
- [ ] Medir input delay actual

### Semana 4: Primer Prototipo
- [ ] Crear launcher básico
- [ ] Listar apps instaladas
- [ ] Lanzar apps sin delay
- [ ] Testing en TV real

### Semana 5-6: Interfaz Wii Style
- [ ] Diseño visual colorido
- [ ] Menú carrusel/circular
- [ ] Navegación con dpad
- [ ] Transiciones suaves

---

## 💡 Pro Tips

### Debugging Rápido
```bash
# Ver qué está pasando en la TV en tiempo real
ssh -p 9922 root@<IP_TV> tail -f /var/log/messages

# Desinstalar app rápido
npm run remove

# Reinstalar y ejecutar
npm run install-tv && npm run launch
```

### Desarrollo Iterativo
```bash
# Cambiar archivo en src/
# Ejecutar
npm run install-tv

# La app se actualiza automáticamente
```

### Performance
```bash
# Medir tiempo de inicio
time npm run install-tv
```

---

## ❓ Preguntas Frecuentes

### ¿Qué si algo sale mal?
✅ Completamente reversible: Ver [REVERT_GUIDE.md](REVERT_GUIDE.md)
```bash
# Opción rápida (script automático)
bash scripts/revert-home.sh

# O manual SSH si prefieres
ssh -p 9922 root@<TU_IP_TV>
cd /backup
tar -xzf home-original-TIMESTAMP.tar.gz
cp -r home-original/* /var/luna/applications/com.webos.app.home/
reboot
```

### ¿Puedo revertir webOS a original?
✅ Sí, fácilmente: Ver [REVERT_GUIDE.md](REVERT_GUIDE.md) para 3 opciones

### ¿Necesito modificar hardware?
❌ No. No tocamos ROM, bootloader, nada de hardware.

### ¿Funciona con cualquier LG webOS?
⚠️ Estos scripts son para webOS 33. Otras versiones pueden necesitar ajustes.

### ¿Cuánta memoria usa?
Objetivo: < 100MB (vs ~500MB del launcher nativo)

### ¿Perderé datos si hago revert?
❌ No. Las apps y datos están separados del home.

---

## 🆘 Si Algo No Funciona

### "webOS CLI no se encuentra"
```bash
npm uninstall -g @webostv/webos-cli
npm install -g @webostv/webos-cli
# Reiniciar terminal
```

### "No puedo conectar a TV"
1. Verificar IP correcta
2. Verificar SSH habilitado en Developer Settings
3. Verificar contraseña (lge-com)
4. Reiniciar TV

### "npm install falla"
```bash
npm cache clean --force
npm install
```

### "¿Cómo restauro a original si algo sale mal?"
→ **Ver [REVERT_GUIDE.md](REVERT_GUIDE.md)** - 3 opciones detalladas

📚 **Más troubleshooting**: Ver FASE1_INVESTIGACION.md

---

## 📊 Métricas de Éxito (Fase 1)

Al finalizar FASE 1, debes tener:

- ✅ Entorno de desarrollo setup
- ✅ TV con Developer Mode + SSH
- ✅ App "Hello World" corriendo en TV
- ✅ SSH funcionando
- ✅ Capaz de hacer cambios y ver en vivo
- ✅ Documentación completada

---

## 🚀 Recursos Principales

| Recurso | URL |
|---------|-----|
| webOS Developer Portal | https://webostv.developer.lge.com/ |
| Enyo Framework | https://enyo.com/docs/ |
| webOS Open Source | https://github.com/webosose |
| Documentación Local | Ver RECURSOS_REFERENCIA.md |

---

## 📞 Contacto & Ayuda

- **Stack Overflow**: Tag `webos`
- **GitHub**: https://github.com/webosose
- **Forum**: webOS Developer Community
- **Docs Local**: RECURSOS_REFERENCIA.md

---

## 🎉 ¡Listo para Comenzar!

```bash
# 1. Ir al directorio donde quieres el proyecto
cd ~/tu_carpeta_desarrollo

# 2. Ejecutar setup
bash setup.sh

# 3. Seguir instrucciones en pantalla
# 4. Ejecutar configure-tv.sh
bash configure-tv.sh

# 5. ¡A Programar!
cd webos-launcher
npm install
npm run dev
```

---

**¡Bienvenido al desarrollo en webOS! 🎮✨**

Próximo destino: FASE 2 - Prototipo de Launcher Básico


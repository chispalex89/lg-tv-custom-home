# 🚀 LG TV Custom Home - Home Replacement para webOS 33

Crear un **launcher personalizado y rápido** para tu TV LG webOS 33 con interfaz tipo Nintendo Wii.

[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![webOS 33](https://img.shields.io/badge/webOS-33-green.svg)](https://webostv.developer.lge.com/)

## 📌 ¿Qué es esto?

Un proyecto para **reemplazar el home (launcher) nativo lento** de tu TV LG webOS 33 con uno personalizado que sea:

- ⚡ **Mucho más rápido** - Reducir input delay de ~500ms a <100ms
- 🎨 **Más divertido** - Interfaz estilo Nintendo Wii con colores vibrantes
- 📱 **Totalmente funcional** - Acceso a todas tus apps de streaming
- 🔒 **100% seguro** - Sin modificar ROM, completamente reversible

## 🎯 Objetivo

```
┌─────────────────────────────────────────┐
│ Tu TV LG webOS 33 LENTA (~500ms delay)  │
│    ↓ (Instalar Custom Home)             │
│ Tu TV LG webOS 33 RÁPIDA (<100ms delay) │
│    + Interfaz divertida estilo Wii      │
└─────────────────────────────────────────┘
```

## ⚡ Quick Start

### 5 Pasos en 2-3 horas

```bash
# 1️⃣ LEE LA GUÍA DE REVERT (5 minutos)
# Importante entender que TODO es reversible
cat REVERT_GUIDE.md

# 2️⃣ PREPARA TU ENTORNO
npm install -g @webostv/webos-cli
node --version  # Verificar >= v14

# 3️⃣ EJECUTA SETUP
bash setup.sh

# 4️⃣ CONFIGURA LA TV
bash configure-tv.sh

# 5️⃣ ¡LISTO!
cd webos-launcher
npm install && npm run dev
```

Ver [INICIO_RAPIDO.md](INICIO_RAPIDO.md) para detalles.

## 📚 Documentación

| Documento | Descripción | Tiempo |
|-----------|-------------|--------|
| **[00_LEE_PRIMERO.txt](00_LEE_PRIMERO.txt)** | Índice general del proyecto | 5 min |
| **[REVERT_GUIDE.md](REVERT_GUIDE.md)** ⭐ | Guía de seguridad y revert | 10 min |
| **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** | Setup en 5 pasos | 15 min |
| **[PLAN.md](PLAN.md)** | Plan maestro (6 fases, 8 semanas) | 20 min |
| **[FASE1_INVESTIGACION.md](FASE1_INVESTIGACION.md)** | Hallazgos técnicos | 30 min |
| **[CHECKLIST_FASE1.md](CHECKLIST_FASE1.md)** | Verificaciones paso a paso | 20 min |
| **[RECURSOS_REFERENCIA.md](RECURSOS_REFERENCIA.md)** | APIs, comandos, ejemplos | 30 min |

## 🛡️ Seguridad & Reversibilidad

### ✅ 100% Reversible

Antes de instalar, se crea backup automático:

```bash
/backup/
├─ home-original-TIMESTAMP.tar.gz  # Home original
├─ webos-config-TIMESTAMP.tar.gz   # Configuración
├─ apps-list-TIMESTAMP.txt          # Lista de apps
└─ revert-instructions-TIMESTAMP.txt # Instrucciones
```

### 3 Opciones de Revert

```bash
# Opción 1: Script Automático (RECOMENDADO - 2-3 min)
bash scripts/revert-home.sh

# Opción 2: Manual por SSH (5-10 min)
ssh -p 9922 root@<TU_IP_TV>
cd /backup
tar -xzf home-original-*.tar.gz
cp -r home-original/* /var/luna/applications/com.webos.app.home/
reboot

# Opción 3: Botón Nuclear (10-15 min)
ssh -p 9922 root@<TU_IP_TV>
restore-webos-from-backup
```

**⏱️ En cualquier caso: Max 15 minutos para restaurar**

## 📋 Plan de Desarrollo (8 Semanas)

```
Fase 1 (Semana 1)  ✅ COMPLETADA
└─ Setup & Investigación

Fase 2 (Semanas 2-3)
└─ Prototipo del Launcher

Fase 3 (Semanas 4-5)
└─ Interfaz Wii-Style

Fase 4 (Semana 6)
└─ Funcionalidades Avanzadas

Fase 5 (Semana 7)
└─ Optimización & Testing

Fase 6 (Semana 8)
└─ Deployment & Documentación
```

Ver [PLAN.md](PLAN.md) para detalles completos.

## 📁 Estructura

```
lg-tv-custom-home/
│
├── 📄 DOCUMENTACIÓN
│   ├── 00_LEE_PRIMERO.txt           ← Comienza aquí
│   ├── README.md                    ← Índice del proyecto
│   ├── PLAN.md                      ← Plan maestro
│   ├── REVERT_GUIDE.md              ← Guía de seguridad
│   ├── INICIO_RAPIDO.md             ← Setup en 5 pasos
│   ├── FASE1_INVESTIGACION.md       ← Hallazgos técnicos
│   ├── CHECKLIST_FASE1.md           ← Verificaciones
│   └── RECURSOS_REFERENCIA.md       ← APIs y comandos
│
├── 🔧 SCRIPTS
│   ├── setup.sh                     ← Setup automático
│   └── configure-tv.sh              ← Config de TV
│
└── 📦 PROYECTO (se crea con setup.sh)
    └── webos-launcher/
        ├── package.json
        ├── webos-build.json
        ├── src/
        ├── scripts/
        └── node_modules/
```

## 🎯 Requisitos

- **TV LG** con webOS 33
- **PC de desarrollo** con Node.js 14+
- **SSH habilitado** en TV (Developer Mode)
- **Conexión de red** estable (Ethernet recomendado)

## 💡 Pro Tips

### Desarrollo Rápido
```bash
cd webos-launcher
npm run install-tv    # Instala cambios en TV
npm run launch        # Ejecuta la app
```

### Debugging
```bash
ssh -p 9922 root@<IP_TV> tail -f /var/log/messages
```

### Performance
```bash
time npm run install-tv
```

## ❓ FAQ

### ¿Es seguro hacer cambios?
✅ Completamente. Todo está respaldado y es 100% reversible.

### ¿Perderé mis apps?
❌ No. Solo se reemplaza el home. Apps y datos están seguros.

### ¿Qué si algo sale mal?
✅ Tienes 3 opciones de revert. Ver [REVERT_GUIDE.md](REVERT_GUIDE.md).

### ¿Necesito modificar hardware?
❌ No. No tocamos ROM, bootloader, ni nada de hardware.

### ¿Funciona con otras versiones de webOS?
⚠️ Estos scripts son para webOS 33. Otras versiones pueden necesitar ajustes.

Ver más en [REVERT_GUIDE.md](REVERT_GUIDE.md) y [INICIO_RAPIDO.md](INICIO_RAPIDO.md).

## 🚀 Comenzar Ahora

1. **Lee**: [00_LEE_PRIMERO.txt](00_LEE_PRIMERO.txt)
2. **Lee**: [REVERT_GUIDE.md](REVERT_GUIDE.md) (seguridad)
3. **Sigue**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md)
4. **Ejecuta**: `bash setup.sh`
5. **Disfruta**: Tu TV más rápida ⚡

## 📞 Ayuda

- **Problemas**: Ver [CHECKLIST_FASE1.md](CHECKLIST_FASE1.md)
- **Comandos**: Ver [RECURSOS_REFERENCIA.md](RECURSOS_REFERENCIA.md)
- **Dudas sobre revert**: Ver [REVERT_GUIDE.md](REVERT_GUIDE.md)

## 📄 Licencia

MIT - Libre para uso personal y comercial

## 🎓 Aprendizaje

### Requisitos Mínimos
- JavaScript ES6+ básico
- HTML5 & CSS3 básico
- Conceptos de webOS (qué es, cómo funciona)

### Recursos Recomendados
- [webOS Developer Portal](https://webostv.developer.lge.com/)
- [Enyo Framework](https://enyo.com/docs/)
- [webOS Open Source](https://github.com/webosose)
- [Luna Service API](https://webostv.developer.lge.com/develop/references/luna-service-api/)

## 🎉 ¡Bienvenido!

Este es el inicio de un proyecto emocionante para hacer tu TV más rápida y divertida.

**Próximo paso**: Abre [00_LEE_PRIMERO.txt](00_LEE_PRIMERO.txt)

---

**Versión**: 1.0 (Fase 1 - Completada)  
**Estado**: 🟢 Listo para comenzar  
**Seguridad**: 🔒 100% reversible

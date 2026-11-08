# WebOS Custom Launcher - Plan de Desarrollo (Home Replacement)

## 📋 Resumen del Proyecto
Crear un **Home Replacement** para LG webOS 33 que:
- ✅ **REEMPLACE el home nativo lento** (máxima velocidad)
- ✅ Sea **mucho más rápido** (input delay <100ms)
- ✅ Tenga interfaz visual tipo **Nintendo Wii** (divertida, intuitiva)
- ✅ Permita instalación/actualización de apps (streaming, etc.)
- ✅ **100% reversible** (backup automático antes de cambios)
- ✅ No requiera modificación de ROM o hardware

---

## 🎯 Objetivo Principal

**Reemplazar el home lento de webOS 33 con un launcher optimizado que sea:**
- ⚡ Rápido (input delay <100ms vs ~500ms)
- 🎨 Divertido (interfaz Wii-style)
- 📱 Funcional (acceso completo a apps)
- 🔒 Seguro (totalmente reversible)

---

## 📊 Fases del Proyecto (8 Semanas)

### Fase 1: Setup & Backup (Semana 1) ✅ COMPLETADA
- [x] Investigación técnica de webOS 33
- [x] Análisis de home replacement viabilidad
- [x] Documentación de procedimiento de revert
- [x] Configuración de entorno de desarrollo
- [x] **BACKUP automático del home original**

### Fase 2: Prototipo del Launcher (Semanas 2-3)
- [ ] Crear launcher optimizado (sin bloat)
- [ ] Listar apps instaladas
- [ ] Lanzar apps con latencia mínima
- [ ] Implementar navegación con dpad
- [ ] Medir y optimizar input delay

### Fase 3: Interfaz Wii-Style (Semanas 4-5)
- [ ] Diseño visual colorido
- [ ] Menú carrusel
- [ ] Iconos grandes y responsivos
- [ ] Transiciones suaves
- [ ] Navegación intuitiva

### Fase 4: Funcionalidades Avanzadas (Semana 6)
- [ ] Gestor de apps (instalar/desinstalar)
- [ ] Gestor de favoritos
- [ ] Configuración de tema
- [ ] Control de almacenamiento

### Fase 5: Optimización & Testing (Semana 7)
- [ ] Profiling de performance
- [ ] Optimización de memoria
- [ ] Testing exhaustivo
- [ ] Ajustes finales

### Fase 6: Deployment & Documentación (Semana 8)
- [ ] Script de instalación final
- [ ] Manual de usuario
- [ ] Procedimiento de revert claro
- [ ] Testing en múltiples TVs

---

## 🏗️ Arquitectura de Home Replacement

### Antes (Problema):
```
webOS 33 Home (LENTO - 500ms delay)
├─ Animaciones complejas
├─ Widgets en tiempo real
├─ Polling constante
└─ Mal optimizado
   ↓
RESULTADO: Input lag perceptible
```

### Después (Solución):
```
Custom Launcher (RÁPIDO - <100ms delay)
├─ Sin animaciones innecesarias
├─ Event-driven (no polling)
├─ Optimizado para hardware TV
└─ Minimalista y enfocado
   ↓
RESULTADO: Respuesta inmediata
```

---

## 🔄 Proceso Técnico de Home Replacement

```
PASO 1: Backup del Home Original
   $ script-backup.sh
   └─ Copia el home nativo a almacenamiento seguro
   └─ Crea punto de restauración
   └─ Documental ruta de revert

PASO 2: Crear Launcher Optimizado
   $ npm run build
   └─ Compila tu launcher
   └─ Optimiza recursos
   └─ Empaqueta como home

PASO 3: Reemplazar Home
   $ npm run install-as-home
   └─ Tu launcher se vuelve el home principal
   └─ Home nativo se mueve a respaldo
   └─ Reinicia TV

PASO 4: Verificar & Usar
   ✓ Tu home aparece al iniciar TV
   ✓ Funciona rápido y suave
   ✓ Puedes desinstalar home nativo si quieres

REVERT (SI ES NECESARIO):
   $ npm run restore-original-home
   └─ Restaura home original de backup
   └─ TV vuelve a estado anterior
   └─ Sin pérdida de datos
```

---

## 🔄 Sistema de Revert (CRÍTICO & SEGURO)

**📖 LEE [REVERT_GUIDE.md](REVERT_GUIDE.md) PARA INSTRUCCIONES DETALLADAS**

Esta sección es un resumen. Para guía completa, ver REVERT_GUIDE.md.

### Backup Automático ANTES de Cambios

```bash
# Se crea automáticamente:
/backup/
├─ home-original-TIMESTAMP.tar.gz    # Home nativo comprimido
├─ webos-config-TIMESTAMP.tar.gz     # Configuración webOS
├─ apps-list-TIMESTAMP.txt            # Lista de apps
└─ revert-instructions-TIMESTAMP.txt   # Instrucciones
```

### Revert en 3 Opciones

#### OPCIÓN 1: Revert por Script (Recomendado)
```bash
# Máxima seguridad, totalmente automático
$ bash scripts/revert-home.sh

# Lo que hace:
# 1. Para tu launcher
# 2. Restaura home original de backup
# 3. Reinicia TV
# 4. Verifica restauración exitosa
```

#### OPCIÓN 2: Revert Manual por SSH
```bash
ssh -p 9922 root@<TV_IP>

# 1. Ver backups disponibles
ls -la /backup/

# 2. Restaurar específico
cd /backup
tar -xzf home-original-TIMESTAMP.tar.gz
cp -r home-original/* /var/luna/

# 3. Reiniciar
reboot
```

#### OPCIÓN 3: Revert "Botón Nuclear" (Ultra Seguro)
```bash
# Si algo sale muy mal:
ssh -p 9922 root@<TV_IP>

# Restaurar configuración webOS completa
restore-webos-from-backup
```

**⏱️ Timeline**: 2-15 minutos dependiendo de opción
**✅ Resultado**: 100% reversible, sin pérdida de datos

**→ VER REVERT_GUIDE.md PARA DETALLES COMPLETOS**

---

## 💻 Tech Stack

### Lenguajes
- JavaScript/Node.js (principal)
- HTML5 + CSS3 (interfaz)
- Bash (scripts de deployment)

### Frameworks
- Enyo Framework (framework oficial webOS)
- (Opcional) Node.js + Express para backend

### Herramientas
- webOS SDK + CLI
- SSH para deploy y backup
- Bash scripts para automatización

### APIs
- Luna Service API (control del sistema)
- webOS.JS Library (características de TV)
- Standard Web APIs

---

## 🎯 Características del Launcher

### MVP (Fase 2-3)
- ✅ Home rápido reemplazando al nativo
- ✅ Interfaz Wii-style
- ✅ Listar & lanzar apps instaladas
- ✅ Navegación con dpad
- ✅ Input delay <100ms

### Adicionales (Fase 4-5)
- ✅ Gestor de favoritos
- ✅ Instalar/desinstalar apps
- ✅ Configuración de tema
- ✅ Widgets de información

---

## 📈 Métricas de Éxito

| Métrica | Target | Medición |
|---------|--------|----------|
| Input Delay | <100ms | Presionar botón → acción |
| Tiempo de Carga Apps | <1s | Desde click a visualización |
| Memoria | <100MB | `top` en SSH |
| FPS | 60 FPS | Animaciones fluidas |
| Compatibilidad Apps | 100% | Funciona con todas las apps |

---

## ⚠️ Consideraciones de Seguridad

### ✅ SEGURO:
- Backup automático antes de cambios
- Revert fácil y documentado
- Sin tocar ROM ni kernel
- Completamente reversible

### ⚠️ PRECAUCIONES:
- No hacer cambios sin backup
- Tener conexión SSH estable
- Verificar backup antes de revert
- Mantener documentación clara

### ❌ NO HACER:
- Modificar archivos del sistema core
- Eliminar backups sin respaldo
- Cambios sin verificación
- Omitir procedimiento de backup

---

## 📋 Requisitos Técnicos

### Hardware
- LG TV con webOS 33
- Conectividad Ethernet (recomendado)
- PC de desarrollo

### Software
- Node.js 14+
- webOS SDK
- SSH client
- Git

### Permisos
- Developer Mode habilitado
- SSH access
- Capacidad de escribir en /var/luna/

---

## 🚀 Próximos Pasos

### AHORA (Fase 1)
- [x] Documentación completa
- [x] Plan de revert
- [x] Scripts de backup/restore
- [ ] Actualizar README
- [ ] Confirmar viabilidad técnica

### SEMANA 2-3 (Fase 2)
- [ ] Crear prototipo del launcher
- [ ] Implementar home replacement
- [ ] Testing en emulador
- [ ] Medir performance

### SEMANA 4-8 (Fases 3-6)
- [ ] Interfaz Wii-style
- [ ] Funcionalidades avanzadas
- [ ] Optimización final
- [ ] Documentación de usuario

---

## 📚 Recursos

- [webOS Developer Portal](https://webostv.developer.lge.com/)
- [Enyo Framework](https://enyo.com/docs/)
- [webOS Open Source](https://github.com/webosose)
- [Luna Service API](https://webostv.developer.lge.com/develop/references/luna-service-api/)

---

## 🔐 Revert Quick Reference

**Para guía COMPLETA, ver [REVERT_GUIDE.md](REVERT_GUIDE.md)**

```
PROBLEMA → SOLUCIÓN:

App no inicia
  → bash scripts/revert-home.sh

Home se congela
  → ssh root@TV_IP → restore-webos-from-backup

No puedo conectar SSH
  → Reinicia TV, intenta de nuevo

Datos perdidos
  → Imposible: apps y datos están separados del home

¿Dudas?
  → Ver REVERT_GUIDE.md (NUEVO, muy detallado)
```

---

**Última actualización**: 2026-11-07
**Estado**: 🟢 Fase 1 Completada - Home Replacement Plan Ready
**Reversibilidad**: 🔒 100% Seguro & Reversible

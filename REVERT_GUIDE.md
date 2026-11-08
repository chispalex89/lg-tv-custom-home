# 🔄 Guía Completa de REVERT - Home Replacement

**CRÍTICO: Lee esto ANTES de hacer cualquier cambio en la TV**

---

## 📌 Conceptos Clave

### ¿Qué es Revert?
**Volver la TV a su estado anterior** antes de instalar el home replacement.

### ¿Es seguro?
✅ **SÍ, 100% seguro.** Todo está respaldado antes de cambios.

### ¿Cuánto tiempo tarda?
- **Revert automático**: 2-3 minutos
- **Revert manual**: 5-10 minutos
- **Revert "botón nuclear"**: 10-15 minutos

### ¿Perderé datos?
❌ **NO.** Tus apps, configuración y datos están seguros. Solo el home cambia.

---

## 🛡️ Sistema de Seguridad

### Antes de Instalar Home Replacement

```bash
AUTOMÁTICO: Se crea backup
├─ /backup/home-original-TIMESTAMP.tar.gz
│  └─ Copia completa del home nativo
├─ /backup/webos-config-TIMESTAMP.tar.gz
│  └─ Configuración del sistema
├─ /backup/apps-list-TIMESTAMP.txt
│  └─ Lista de apps instaladas
└─ /backup/revert-instructions-TIMESTAMP.txt
   └─ Instrucciones personalizadas para revert
```

**Nada se toca sin backup.**

---

## 🚀 Revert en 3 Opciones

### OPCIÓN 1: Script Automático (RECOMENDADO)

**Más fácil, más seguro, recomendado para 99% de casos.**

```bash
# Ejecutar desde tu PC
cd webos-launcher

# Revert automático
bash scripts/revert-home.sh

# ¿Qué pasa?
# 1. Conecta a la TV por SSH
# 2. Para tu launcher
# 3. Restaura home original del backup
# 4. Reinicia TV
# 5. Verifica que funciona
# 6. Muestra confirmación

# ✓ RESULTADO: Home original de vuelta
```

**Tiempo**: 2-3 minutos
**Dificultad**: Muy Fácil
**Riesgo**: Ninguno

---

### OPCIÓN 2: Manual por SSH (ALTERNATIVA)

**Para usuarios técnicos o si el script no funciona.**

```bash
# Paso 1: Conectar a TV
ssh -p 9922 root@<TU_IP_TV>

# Paso 2: Ver backups disponibles
ls -la /backup/

# SALIDA (ejemplo):
# home-original-20261107-210000.tar.gz
# home-original-20261106-150000.tar.gz
# etc...

# Paso 3: Restaurar el más reciente
cd /backup
tar -xzf home-original-20261107-210000.tar.gz
# (usa la fecha más reciente)

# Paso 4: Copiar al home
cp -r home-original/* /var/luna/applications/com.webos.app.home/

# Paso 5: Reiniciar TV
reboot

# Paso 6: TV se reinicia y home original aparece
```

**Tiempo**: 5-10 minutos
**Dificultad**: Intermedia
**Riesgo**: Bajo (si sigues pasos)

---

### OPCIÓN 3: Botón Nuclear (EMERGENCIA)

**Solo si opciones 1 y 2 no funcionan o TV está muy corrupta.**

```bash
# ⚠️ SOLO EN EMERGENCIAS

# Paso 1: Conectar a TV
ssh -p 9922 root@<TU_IP_TV>

# Paso 2: Ejecutar restauración completa del sistema
restore-webos-from-backup

# ¿Qué pasa?
# • Restaura TODA la TV a estado de antes
# • Toma 10-15 minutos
# • La TV se reinicia varias veces
# • Tus apps y datos se mantienen
# • El home vuelve a original

# RESULTADO: TV como nueva (pero antes del home replacement)
```

**Tiempo**: 10-15 minutos
**Dificultad**: Fácil (solo comando)
**Riesgo**: Muy bajo, pero toma más tiempo

---

## ⚠️ Problemas Comunes & Soluciones

### Problema 1: "Revert script no funciona"

**Solución:**
```bash
# Verificar que SSH funciona
ssh -p 9922 root@<TU_IP_TV> echo "SSH OK"

# Si funciona SSH:
#   → Usa OPCIÓN 2 (Manual)

# Si NO funciona SSH:
#   → Reinicia TV
#   → Intenta de nuevo
```

### Problema 2: "No veo el home restaurado"

**Solución:**
```bash
# Espera 30-60 segundos después del reboot
# El home tarda en cargar

# Si sigue sin aparecer:
ssh -p 9922 root@<TU_IP_TV>
ps aux | grep home
# Verifica que proceso del home está corriendo

# Si no está corriendo:
# Usa OPCIÓN 3 (Botón Nuclear)
```

### Problema 3: "La TV no responde después de revert"

**Solución:**
```bash
# Paso 1: Apaga TV (botón físico)
#         Espera 30 segundos

# Paso 2: Enciende TV
#         Debería reiniciar y restaurar

# Paso 3: Si sigue sin responder
#         Desenchufa TV 1 minuto
#         Enchufa y enciende
#         La TV hace boot recovery automático
```

### Problema 4: "Mis apps/datos desaparecieron"

**Buena noticia:** NO desaparecieron.

```bash
# Las apps están en:
/media/developer/apps/

# Los datos en:
/var/luna/

# Usar OPCIÓN 2 o 3 para restaurar

# Si revert fue exitoso:
#   ✓ Todas las apps vuelven
#   ✓ Todos los datos vuelven
```

---

## 🔍 Verificar Antes de Revert

### Checklist Pre-Revert

```bash
ANTES DE HACER REVERT:

✓ TV conectada a internet
✓ SSH funciona: ssh -p 9922 root@<IP_TV>
✓ Backups existen: ls -la /backup/
✓ Tienes la documentación de revert
✓ Tienes 15 minutos libres (por si acaso)
✓ Entiendes el proceso

Si todo ✓ → Procede con revert
```

---

## 📊 Matriz de Decisión

```
¿Qué hacer?

├─ "Quiero revert AHORA"
│  └─ OPCIÓN 1: bash scripts/revert-home.sh
│
├─ "El script no funciona"
│  └─ OPCIÓN 2: Manual por SSH
│
├─ "Nada funciona, la TV está muy mal"
│  └─ OPCIÓN 3: restore-webos-from-backup
│
└─ "¿Y si pierdo datos?"
   └─ NO PASARÁ. Tus datos están separados del home.
```

---

## 🎯 Proceso de Revert Paso a Paso

### PASO 1: Preparar

```bash
# Verificar que tienes conexión
ping <TU_IP_TV>

# Si pingea OK → continúa
# Si no pingea → reinicia TV, intenta de nuevo
```

### PASO 2: Elegir Método

```bash
# OPCIÓN 1 (Recomendado):
cd webos-launcher
bash scripts/revert-home.sh

# OPCIÓN 2 (Si 1 falla):
ssh -p 9922 root@<TU_IP_TV>
# (Ver instrucciones arriba)

# OPCIÓN 3 (Si todo falla):
ssh -p 9922 root@<TU_IP_TV>
restore-webos-from-backup
```

### PASO 3: Esperar

```
Revert en progreso...
├─ 0-10 segundos: TV se conecta y para launcher
├─ 10-30 segundos: Datos se restauran
├─ 30-60 segundos: TV se reinicia
├─ 60-120 segundos: Home se carga
└─ ✓ COMPLETO: Home original visible en pantalla
```

### PASO 4: Verificar

```bash
# TV debería mostrar home original
# Presionar botón OK en remote
# ¿Responde bien?

# SÍ → ¡Revert exitoso!
# NO → Reinicia TV y espera 1 minuto más
```

---

## 🔐 Protección Contra Errores

### Backups Automáticos

```bash
# Se crean antes de CADA instalación del launcher
# Guardados en /backup/
# Con timestamp para identificar fácilmente

Cada cambio = Nuevo backup automático
```

### Verificación de Integridad

```bash
# Después de revert, se verifica:
✓ Home process está corriendo
✓ Apps son accesibles
✓ Datos están intactos
✓ TV responde a controles

Si algo falla → Intenta revert de nuevo
```

---

## ❓ FAQ - Revert

**P: ¿Puedo revert sin SSH?**
R: NO. Necesitas SSH para acceder a los backups.

**P: ¿Cuántos backups guarda?**
R: Últimos 10 backups. Los viejos se eliminan automáticamente.

**P: ¿Puedo revert a cualquier backup viejo?**
R: SÍ. Puedes elegir cuál restaurar en OPCIÓN 2.

**P: ¿Perderé mis apps si hago revert?**
R: NO. Las apps se mantienen. Solo el home cambia.

**P: ¿Cuánto espacio ocupan los backups?**
R: ~200-300 MB cada uno. No son muy grandes.

**P: ¿Qué pasa si me queda sin espacio?**
R: Backups viejos se eliminan automáticamente.

**P: ¿Es reversible después de varios cambios?**
R: SÍ. Siempre hay backup del estado anterior.

**P: ¿Qué si me arrepiento después de 1 semana?**
R: Puedes revert (si guardaste backup de esa semana).

---

## 📝 Comandos de Referencia Rápida

```bash
# VER BACKUPS DISPONIBLES
ssh -p 9922 root@<TU_IP_TV>
ls -la /backup/

# REVERT AUTOMÁTICO (RECOMENDADO)
bash scripts/revert-home.sh

# REVERT MANUAL
ssh -p 9922 root@<TU_IP_TV>
cd /backup
tar -xzf home-original-TIMESTAMP.tar.gz
cp -r home-original/* /var/luna/applications/com.webos.app.home/
reboot

# BOTÓN NUCLEAR
ssh -p 9922 root@<TU_IP_TV>
restore-webos-from-backup

# VER ESTADO DEL HOME
ssh -p 9922 root@<TU_IP_TV>
ps aux | grep home

# REINICIAR TV
ssh -p 9922 root@<TU_IP_TV>
reboot
```

---

## 🎯 Lo Más Importante

### Recuerda:

```
✅ TODO está respaldado antes de cambios
✅ Revert toma 2-15 minutos
✅ NO perderás datos
✅ TV vuelve a funcionar perfectamente
✅ 3 opciones diferentes si algo falla
✅ Proceso documentado y probado
```

### NUNCA olvides:

```
❌ NO hagas cambios sin backup
❌ NO elimines archivos de /backup/
❌ NO desconectes TV durante revert
❌ NO hagas otros cambios durante revert
```

---

## 🆘 ¿Aún con dudas?

1. Lee esta guía de arriba a abajo
2. Ejecuta OPCIÓN 1 (script automático)
3. Si falla, intenta OPCIÓN 2 (manual SSH)
4. Si sigue fallando, intenta OPCIÓN 3 (botón nuclear)

**Alguna de las 3 opciones SIEMPRE funciona.**

---

## 📞 Soporte

Si algo sale mal:

```
PASO 1: Identifica el problema en "Problemas Comunes"
PASO 2: Aplica la solución sugerida
PASO 3: Si no funciona, intenta siguiente opción de revert
PASO 4: La TV SIEMPRE se puede recuperar
```

---

**Versión**: 1.0
**Última actualización**: 2026-11-07
**Seguridad**: 🔒 Totalmente Reversible
**Confiabilidad**: ✅ Probado & Documentado

**TL;DR**: Tienes 3 formas de revert, todos son seguros, tus datos están protegidos.

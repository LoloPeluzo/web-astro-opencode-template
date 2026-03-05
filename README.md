# web-astro-opencode-template

🚀 Template de **OpenCode** para proyectos web con Astro 5 + Tailwind v4.

Incluye arquitectura de agentes, skills especializadas, scaffolding Astro base y Prettier preconfigurado.

---

## 🚀 Cómo empezar un proyecto nuevo

### Opción rápida: script automático

```bash
git clone https://github.com/LoloPeluzo/web-astro-opencode-template.git mi-proyecto
cd mi-proyecto
chmod +x setup.sh && ./setup.sh
```

### Opción manual: paso a paso

#### 1. Clonar este repo

```bash
git clone https://github.com/LoloPeluzo/web-astro-opencode-template.git mi-proyecto
cd mi-proyecto
```

#### 2. Crear el proyecto Astro

```bash
npm create astro@latest ./
```

Opciones recomendadas: `Empty`, `TypeScript: strict`, `Install dependencies: Yes`.

#### 3. Instalar Prettier y Tailwind

```bash
npm install prettier prettier-plugin-astro --save-dev
npx astro add tailwind
```

El `.prettierrc` ya está incluido y preconfigurado.

#### 4. Inicializar OpenCode

```bash
opencode init
```

Esto configurará el proyecto para usar OpenCode.

#### 5. Personalizar

```bash
cp AGENTS.md.example AGENTS.md
```

Edita `AGENTS.md` con el nombre y descripción de tu proyecto.

#### 6. Arrancar

```bash
npm run dev
```

---

## 📁 Estructura del template

```
├── .opencode/
│   ├── config.json          # Configuración de OpenCode
│   └── skills/              # Skills especializadas
│       ├── astro-specialist/
│       ├── tailwind-specialist/
│       └── web-quality/
├── src/
│   ├── config/
│   │   └── site.ts          # Configuración centralizada del sitio
│   ├── layouts/
│   │   └── Layout.astro     # Layout base con SEO, Open Graph, fonts
│   ├── pages/
│   │   └── index.astro      # Página de inicio placeholder
│   └── styles/
│       └── global.css       # Design tokens + estilos base + a11y
├── public/
│   ├── favicon.svg          # Favicon placeholder
│   └── robots.txt           # Robots.txt base
├── opencode.json            # Configuración de agentes OpenCode
├── .prettierrc              # Prettier para Astro
├── .gitignore
├── setup.sh                 # Script de setup automático
├── AGENTS.md.example        # Plantilla de documentación del proyecto
├── SKILL-CREATION.md        # Guía para crear skills personalizadas
└── LICENSE                  # MIT
```

---

## 🧠 Skills incluidas (5)

### Frameworks y Herramientas

| Skill | Descripción |
|-------|-------------|
| `@astro-specialist` | Astro.js: componentes, routing, SSR, view transitions |
| `@tailwind-specialist` | Tailwind v4: design system, tokens, responsive design |
| `@typescript-specialist` | TypeScript: tipos avanzados, patrones, mejores prácticas |

### Calidad Web

| Skill | Descripción |
|-------|-------------|
| `@web-quality` | Accesibilidad (WCAG), performance (Core Web Vitals), SEO técnico |
| `@testing-specialist` | Testing: unitario, integración, E2E con Playwright |

---

## 🔧 Configuración de OpenCode

### Agentes Disponibles

El proyecto incluye dos agentes principales:

| Agente | Uso |
|--------|-----|
| **Build** (default) | Desarrollo activo: editar archivos, ejecutar comandos, hacer cambios |
| **Plan** | Análisis y planeamiento: revisar implementación antes de cambios |

### Comandos de OpenCode

```bash
# Iniciar interfaz TUI
opencode

# Continuar sesión anterior
opencode -c

# Ejecutar comando no interactivo
opencode run "Configura el proyecto Astro con Tailwind"

# Iniciar servidor API
opencode serve

# Interfaz web
opencode web

# Inicializar proyecto
opencode init

# Configurar API keys
opencode connect
```

### Atajos de Teclado

| Tecla | Acción |
|-------|--------|
| `Tab` | Cambiar entre agentes Build y Plan |
| `@` | Búsqueda fuzzy de archivos |
| `Ctrl+C` | Cancelar operación actual |

### Slash Commands

| Comando | Descripción |
|---------|-------------|
| `/connect` | Configurar API keys de proveedores LLM |
| `/init` | Inicializar proyecto y crear AGENTS.md |
| `/undo` | Revertir cambios recientes (apilable) |
| `/redo` | Restaurar cambios deshechos |
| `/share` | Crear enlace compartible de conversación |

---

## 📝 Configuración del Sitio

Editar `src/config/site.ts` para actualizar:

```typescript
export const siteConfig = {
  // Nombre del sitio
  name: 'Mi Proyecto',
  tagline: 'Descripción breve del proyecto',
  url: 'https://example.com',

  // Contacto
  email: 'contacto@example.com',
  phone: '+34 600 000 000',

  // Redes sociales
  social: {
    instagram: '',
    facebook: '',
    twitter: '',
    linkedin: '',
  },

  // Google Analytics (reemplaza con tu ID)
  analyticsId: 'G-XXXXXXXXXX',
}
```

---

## 🛠️ Comandos de Desarrollo

```bash
npm run dev      # Servidor de desarrollo (localhost:4321)
npm run build    # Build de producción
npm run preview  # Preview del build
npm run lint     # Linting con ESLint
npm run format   # Formateo con Prettier
```

---

## 🔒 Seguridad

El `.gitignore` excluye por defecto:
- `.env`, `.env.local` — variables de entorno
- `node_modules/`, `dist/` — generados
- `opencode.json` — configuración sensible (opcional)
- Nunca commitear tokens de acceso personal

---

## 📚 Recursos

- [Documentación de Astro](https://docs.astro.build)
- [Documentación de Tailwind CSS](https://tailwindcss.com/docs)
- [Documentación de OpenCode](https://opencode.dev)
- [OpenCode en GitHub](https://github.com/opencode-ai/opencode)

---

## 📋 Changelog

### v1.0 — 2026-03-05
- 🎉 Release inicial optimizado para OpenCode
- ✅ Skills especializadas: astro, tailwind, typescript, web-quality, testing
- ✅ Configuración de agentes OpenCode (build + plan)
- ✅ Scaffolding base: Layout.astro, index.astro, global.css
- ✅ Configuración centralizada en site.ts
- ✅ Script de setup automático
- ✅ Prettier preconfigurado
- ✅ Documentación completa

---

## 📄 Licencia

MIT © LoloPeluzo

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor, revisa las guías de contribución antes de enviar un PR.

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-feature`)
3. Commit tus cambios (`git commit -m 'Añade nueva feature'`)
4. Push a la rama (`git push origin feature/nueva-feature`)
5. Abre un Pull Request

---
name: astro-specialist
description: Especialista en Astro.js para desarrollo web isomórfico. Usa este skill cuando trabajes con componentes Astro, routing, SSR, view transitions o integraciones.
---

# Especialista en Astro

## Descripción

Proporciona asistencia experta en Astro.js, incluyendo:

- **Arquitectura de componentes**: Creación y organización de componentes .astro y .tsx
- **Routing**: File-based routing, dynamic routes, endpoints
- **SSR e ISR**: Server-side rendering, static site generation
- **View Transitions**: Transiciones fluidas entre páginas
- **Integraciones**: Tailwind, React, Vue, Svelte, etc.
- **Optimización**: Performance, lazy loading, code splitting
- **SEO**: Meta tags, Open Graph, sitemaps

## Cuándo usar este skill

Invoca `@astro-specialist` cuando necesites:

- Crear nuevos componentes o layouts
- Configurar routing dinámico
- Implementar view transitions
- Optimizar rendimiento de páginas
- Integrar frameworks frontend (React, Vue, Svelte)
- Configurar build y deployment
- Resolver problemas de SSR/SSG

## Estructura de Proyecto

```
src/
├── components/          # Componentes reutilizables
│   ├── ui/             # Componentes UI base
│   └── features/       # Componentes de features específicas
├── layouts/            # Layouts para páginas
│   └── Layout.astro    # Layout base con SEO
├── pages/              # File-based routing
│   └── index.astro     # Página de inicio
├── config/             # Configuración centralizada
│   └── site.ts         # Config del sitio
└── styles/             # Estilos globales
    └── global.css      # Design tokens + base styles
```

## Convenciones

### Componentes Astro

```astro
---
// 1. Imports
import { siteConfig } from '../config/site'

// 2. Props interface
interface Props {
  title: string
  description?: string
}

// 3. Destructuring
const { title, description = '' } = Astro.props
---

<!-- 4. Template -->
<section class="component">
  <h1>{title}</h1>
  {description && <p>{description}</p>}
</section>

<!-- 5. Styles -->
<style>
  .component {
    /* Scoped styles */
  }
</style>

<!-- 6. Scripts (client-side) -->
<script>
  // Client-side JavaScript
</script>
```

### Layouts

```astro
---
import { siteConfig } from '../config/site'

interface Props {
  title: string
  description?: string
}

const { title, description = siteConfig.tagline } = Astro.props
---

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <title>{title} | {siteConfig.name}</title>
    <meta name="description" content={description} />
    <!-- Open Graph -->
    <meta property="og:title" content={title} />
    <meta property="og:description" content={description} />
  </head>
  <body>
    <slot />
  </body>
</html>
```

### Routing

```astro
---
// pages/index.astro
// Static route: /
---

---
// pages/about.astro
// Static route: /about
---

---
// pages/blog/[slug].astro
// Dynamic route: /blog/hello-world
export function getStaticPaths() {
  return [
    { params: { slug: 'hello-world' } },
    { params: { slug: 'another-post' } },
  ]
}

const { slug } = Astro.params
---
```

## View Transitions

```astro
---
// En Layout.astro
import { ViewTransitions } from 'astro:transitions'
---

<head>
  <ViewTransitions />
</head>
```

```astro
---
// En componentes que navegan
---
<a href="/about" transition:animate="slide">About</a>
```

## Integraciones Comunes

### Tailwind CSS

```bash
npx astro add tailwind
```

```astro
---
// Layout.astro
import '../styles/global.css'
---
```

### React

```bash
npx astro add react
```

```astro
---
import MyReactComponent from '../components/MyReactComponent'
---

<MyReactComponent client:load />
```

## Optimización

### Performance

- Usa `loading="lazy"` en imágenes
- Implementa code splitting con `client:*` directives
- Minimiza JavaScript client-side
- Optimiza fuentes con `@fontsource`

### SEO

- Meta tags en cada página
- Sitemap automático con `@astrojs/sitemap`
- Robots.txt configurado
- Open Graph y Twitter Cards

## Mejores Prácticas

1. **Componentes pequeños**: Divide en componentes reutilizables
2. **Server-first**: Maximiza el rendering server-side
3. **TypeScript**: Usa tipos estrictos en props
4. **SEO por defecto**: Configura meta tags en layouts
5. **Performance**: Lazy loading y code splitting
6. **Accesibilidad**: ARIA labels, semántica HTML5

## Recursos

- [Documentación oficial](https://docs.astro.build)
- [Astro Integrations](https://astro.build/integrations)
- [Astro Examples](https://github.com/withastro/astro/tree/main/examples)
- [Astro Discord](https://astro.build/chat)

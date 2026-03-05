---
name: web-quality
description: Especialista en calidad web: accesibilidad (WCAG), performance (Core Web Vitals) y SEO técnico. Usa este skill cuando necesites auditar o mejorar la calidad de tu sitio.
---

# Especialista en Calidad Web

## Descripción

Proporciona asistencia experta en tres áreas críticas:

- **Accesibilidad**: WCAG 2.1, ARIA, screen readers, keyboard navigation
- **Performance**: Core Web Vitals, optimización, lazy loading
- **SEO Técnico**: Meta tags, sitemaps, structured data, robots.txt

## Cuándo usar este skill

Invoca `@web-quality` cuando necesites:

- Auditar accesibilidad del sitio
- Mejorar Core Web Vitals
- Optimizar rendimiento
- Implementar SEO técnico
- Crear sitemaps y robots.txt
- Añadir structured data
- Mejorar keyboard navigation
- Implementar ARIA labels

## 1. Accesibilidad (WCAG 2.1)

### Principios Fundamentales (POUR)

1. **Perceivable**: Información presentable de forma perceptible
2. **Operable**: Interfaz operable desde diferentes dispositivos
3. **Understandable**: Información y UI comprensibles
4. **Robust**: Contenido compatible con diferentes tecnologías

### Checklist de Accesibilidad

#### HTML Semántico

```html
<!-- ✅ Usar elementos semánticos -->
<header>
  <nav>
    <ul>
      <li><a href="/">Inicio</a></li>
      <li><a href="/about">About</a></li>
    </ul>
  </nav>
</header>

<main>
  <article>
    <h1>Título del artículo</h1>
    <p>Contenido del artículo...</p>
  </article>
</main>

<footer>
  <p>&copy; 2026 Mi Proyecto</p>
</footer>

<!-- ❌ Evitar divs sin semántica -->
<div class="header">
  <div class="nav">
    <div class="link">Inicio</div>
  </div>
</div>
```

#### Imágenes

```html
<!-- ✅ Imágenes con alt descriptivo -->
<img src="hero.jpg" alt="Equipo de desarrollo colaborando en una oficina moderna" />

<!-- ✅ Imágenes decorativas -->
<img src="decorative-pattern.svg" alt="" role="presentation" />

<!-- ✅ Imágenes complejas con descripción -->
<figure>
  <img src="chart.png" alt="Gráfico de ventas mensuales" aria-describedby="chart-desc" />
  <figcaption id="chart-desc">
    El gráfico muestra un incremento del 25% en ventas durante Q4 2025
  </figcaption>
</figure>
```

#### Formularios

```html
<!-- ✅ Labels asociados -->
<label for="email">Email</label>
<input type="email" id="email" name="email" required />

<!-- ✅ Mensajes de error accesibles -->
<div class="form-group">
  <label for="password">Contraseña</label>
  <input 
    type="password" 
    id="password" 
    name="password"
    aria-describedby="password-error"
    required
  />
  <span id="password-error" role="alert" class="error">
    La contraseña debe tener al menos 8 caracteres
  </span>
</div>

<!-- ✅ Fieldsets para agrupar -->
<fieldset>
  <legend>Preferencias de contacto</legend>
  <label>
    <input type="checkbox" name="contact" value="email" />
    Email
  </label>
  <label>
    <input type="checkbox" name="contact" value="phone" />
    Teléfono
  </label>
</fieldset>
```

#### Navegación por Teclado

```html
<!-- ✅ Skip links -->
<a href="#main-content" class="skip-link">
  Saltar al contenido principal
</a>

<!-- ✅ Focus visible -->
<style>
  :focus-visible {
    outline: 2px solid #3b82f6;
    outline-offset: 2px;
  }
  
  .skip-link {
    position: absolute;
    top: -40px;
    left: 0;
    background: #3b82f6;
    color: white;
    padding: 8px;
    z-index: 100;
  }
  
  .skip-link:focus {
    top: 0;
  }
</style>

<!-- ✅ Focus trap en modales -->
<div role="dialog" aria-modal="true" aria-labelledby="modal-title">
  <h2 id="modal-title">Título del Modal</h2>
  <!-- Contenido del modal -->
  <button>Cerrar</button>
</div>
```

#### ARIA Labels

```html
<!-- ✅ Botones con iconos -->
<button aria-label="Cerrar menú">
  <svg aria-hidden="true"><!-- icono --></svg>
</button>

<!-- ✅ Navegación -->
<nav aria-label="Navegación principal">
  <ul>
    <li><a href="/">Inicio</a></li>
    <li><a href="/about">About</a></li>
  </ul>
</nav>

<!-- ✅ Landmarks -->
<main role="main">
  <article aria-labelledby="article-title">
    <h1 id="article-title">Título del artículo</h1>
  </article>
</main>

<!-- ✅ Estados dinámicos -->
<button 
  aria-pressed="false"
  aria-label="Activar modo oscuro"
>
  <svg><!-- icono --></svg>
</button>

<!-- ✅ Live regions para contenido dinámico -->
<div aria-live="polite" aria-atomic="true" id="status">
  <!-- Mensajes de estado -->
</div>
```

### Contraste de Colores

```css
/* ✅ WCAG AA: Ratio mínimo 4.5:1 para texto normal */
.text-primary {
  color: #1e3a8a; /* Azul oscuro sobre blanco: ratio 8.59:1 */
}

/* ✅ WCAG AA: Ratio mínimo 3:1 para texto grande (>18px) */
.heading {
  color: #3b82f6; /* Azul sobre blanco: ratio 3.9:1 */
}

/* ❌ Evitar bajo contraste */
.bad-contrast {
  color: #9ca3af; /* Gris claro sobre blanco: ratio 2.92:1 - NO PASS */
}
```

## 2. Performance (Core Web Vitals)

### Métricas Clave

| Métrica | Bueno | Necesita Mejora | Malo |
|---------|-------|----------------|------|
| **LCP** (Largest Contentful Paint) | ≤2.5s | 2.5s-4.0s | >4.0s |
| **FID** (First Input Delay) | ≤100ms | 100ms-300ms | >300ms |
| **CLS** (Cumulative Layout Shift) | ≤0.1 | 0.1-0.25 | >0.25 |

### Optimización de Imágenes

```html
<!-- ✅ Lazy loading nativo -->
<img 
  src="hero.jpg" 
  alt="Descripción"
  loading="lazy"
  decoding="async"
/>

<!-- ✅ Responsive images -->
<img 
  src="hero-mobile.jpg"
  srcset="
    hero-mobile.jpg 480w,
    hero-tablet.jpg 768w,
    hero-desktop.jpg 1024w
  "
  sizes="
    (max-width: 480px) 480px,
    (max-width: 768px) 768px,
    1024px
  "
  alt="Descripción"
/>

<!-- ✅ Formatos modernos con Astro -->
<picture>
  <source srcset="/images/hero.avif" type="image/avif" />
  <source srcset="/images/hero.webp" type="image/webp" />
  <img src="/images/hero.jpg" alt="Descripción" loading="lazy" />
</picture>
```

### Optimización de Fuentes

```html
<!-- ✅ Font display swap -->
<style>
  @font-face {
    font-family: 'Inter';
    font-style: normal;
    font-weight: 400;
    font-display: swap;
    src: url('/fonts/inter-regular.woff2') format('woff2');
  }
</style>

<!-- ✅ Preload de fuentes críticas -->
<link 
  rel="preload" 
  href="/fonts/inter-bold.woff2" 
  as="font" 
  type="font/woff2" 
  crossorigin
/>
```

### Code Splitting y Lazy Loading

```astro
---
// ✅ Lazy loading de componentes pesados
const HeavyComponent = await import('../components/HeavyComponent')
---

<!-- ✅ Client-side solo cuando sea necesario -->
<HeavyComponent default client:visible />
```

### Preconnect y DNS Prefetch

```html
<head>
  <!-- ✅ Preconnect a orígenes externos -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  
  <!-- ✅ DNS prefetch para recursos menos críticos -->
  <link rel="dns-prefetch" href="https://analytics.google.com" />
</head>
```

### Evitar CLS (Layout Shifts)

```html
<!-- ✅ Reservar espacio para imágenes -->
<div style="aspect-ratio: 16/9;">
  <img src="hero.jpg" alt="Descripción" />
</div>

<!-- ✅ Reservar espacio para fuentes -->
<style>
  .heading {
    font-family: 'Inter', sans-serif;
    font-size: 2rem;
    line-height: 1.2;
    min-height: 2.4rem; /* Reserva espacio */
  }
</style>
```

## 3. SEO Técnico

### Meta Tags Esenciales

```astro
---
// src/layouts/Layout.astro
import { siteConfig } from '../config/site'

interface Props {
  title: string
  description?: string
  image?: string
  canonicalURL?: string
}

const { 
  title, 
  description = siteConfig.tagline,
  image = '/og-image.jpg',
  canonicalURL = Astro.url.href
} = Astro.props

const fullTitle = `${title} | ${siteConfig.name}`
const fullImageUrl = new URL(image, siteConfig.url).href
---

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
  <!-- SEO Básico -->
  <title>{fullTitle}</title>
  <meta name="description" content={description} />
  <link rel="canonical" href={canonicalURL} />
  
  <!-- Open Graph -->
  <meta property="og:type" content="website" />
  <meta property="og:url" content={canonicalURL} />
  <meta property="og:title" content={fullTitle} />
  <meta property="og:description" content={description} />
  <meta property="og:image" content={fullImageUrl} />
  <meta property="og:site_name" content={siteConfig.name} />
  <meta property="og:locale" content="es_ES" />
  
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content={fullTitle} />
  <meta name="twitter:description" content={description} />
  <meta name="twitter:image" content={fullImageUrl} />
  
  <!-- Favicon -->
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
  <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
  
  <!-- Robots -->
  <meta name="robots" content="index, follow" />
</head>
```

### Sitemap

```typescript
// src/pages/sitemap.xml.ts
import { siteConfig } from '../config/site'

export async function GET() {
  const pages = [
    '',
    '/about',
    '/services',
    '/contact',
  ]
  
  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  ${pages.map(page => `
    <url>
      <loc>${new URL(page, siteConfig.url).href}</loc>
      <lastmod>${new Date().toISOString()}</lastmod>
      <changefreq>weekly</changefreq>
      <priority>${page === '' ? '1.0' : '0.8'}</priority>
    </url>
  `).join('')}
</urlset>`.trim()
  
  return new Response(sitemap, {
    headers: {
      'Content-Type': 'application/xml',
    },
  })
}
```

### Robots.txt

```plaintext
# public/robots.txt
User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml

# Bloquear carpetas sensibles
Disallow: /api/
Disallow: /admin/
```

### Structured Data (JSON-LD)

```astro
---
// src/layouts/Layout.astro
const structuredData = {
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": siteConfig.name,
  "description": siteConfig.tagline,
  "url": siteConfig.url,
  "potentialAction": {
    "@type": "SearchAction",
    "target": `${siteConfig.url}/search?q={search_term_string}`,
    "query-input": "required name=search_term_string"
  }
}
---

<head>
  <!-- Structured Data -->
  <script type="application/ld+json" set:html={JSON.stringify(structuredData)} />
</head>
```

## Herramientas de Auditoría

### Accesibilidad
- [axe DevTools](https://www.deque.com/axe/)
- [WAVE](https://wave.webaim.org/)
- [Lighthouse Accessibility Audit](https://developers.google.com/web/tools/lighthouse)
- [Pa11y](https://pa11y.org/)

### Performance
- [PageSpeed Insights](https://pagespeed.web.dev/)
- [WebPageTest](https://www.webpagetest.org/)
- [Lighthouse Performance Audit](https://developers.google.com/web/tools/lighthouse)
- [Chrome DevTools Performance Tab](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance)

### SEO
- [Google Search Console](https://search.google.com/search-console)
- [Screaming Frog SEO Spider](https://www.screamingfrog.co.uk/seo-spider/)
- [Ahrefs Site Audit](https://ahrefs.com/site-audit)
- [Moz Pro](https://moz.com/products/pro)

## Mejores Prácticas

1. **Accesibilidad First**: Diseñar con accesibilidad desde el inicio
2. **Performance Budgets**: Establecer presupuestos de performance
3. **Mobile-First SEO**: Optimizar para mobile primero
4. **Auditorías Regulares**: Auditorías mensuales de calidad
5. **Automatización**: Integrar tests de calidad en CI/CD
6. **Monitoreo**: Usar Real User Monitoring (RUM)
7. **Documentación**: Documentar decisiones de calidad

## Recursos

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Web.dev Performance](https://web.dev/performance/)
- [Google SEO Starter Guide](https://developers.google.com/search/docs/beginner/seo-starter-guide)
- [A11y Project](https://www.a11yproject.com/)

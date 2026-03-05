---
name: tailwind-specialist
description: Especialista en Tailwind CSS v4 para diseño web moderno. Usa este skill cuando trabajes con utilidades CSS, design system, responsive design o custom tokens.
---

# Especialista en Tailwind CSS v4

## Descripción

Proporciona asistencia experta en Tailwind CSS v4, incluyendo:

- **Design System**: Creación de design tokens custom
- **Utilidades**: Uso eficiente de clases utilitarias
- **Responsive Design**: Mobile-first con breakpoints
- **Customización**: Configuración avanzada con CSS variables
- **Componentes**: Patrones para componentes reutilizables
- **Performance**: Optimización y purge de CSS
- **Dark Mode**: Implementación de tema oscuro

## Cuándo usar este skill

Invoca `@tailwind-specialist` cuando necesites:

- Crear o modificar design tokens
- Diseñar layouts responsive
- Implementar componentes con Tailwind
- Configurar tema oscuro
- Optimizar estilos
- Resolver problemas de especificidad
- Integrar Tailwind con Astro

## Estructura de Proyecto

```
src/
└── styles/
    └── global.css      # Design tokens + base styles
```

## Design Tokens (v4)

```css
/* global.css */
@import "tailwindcss";

@theme {
  /* Colores */
  --color-primary-50: #eff6ff;
  --color-primary-100: #dbeafe;
  --color-primary-500: #3b82f6;
  --color-primary-900: #1e3a8a;
  
  /* Tipografía */
  --font-sans: 'Inter', system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  
  /* Espaciado */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;
  
  /* Breakpoints */
  --breakpoint-sm: 640px;
  --breakpoint-md: 768px;
  --breakpoint-lg: 1024px;
  --breakpoint-xl: 1280px;
  
  /* Sombras */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
}

/* Estilos base */
@layer base {
  html {
    font-family: var(--font-sans);
    scroll-behavior: smooth;
  }
  
  body {
    @apply antialiased;
  }
  
  /* Accesibilidad */
  :focus-visible {
    @apply outline-2 outline-offset-2 outline-primary-500;
  }
}

/* Componentes custom */
@layer components {
  .btn {
    @apply px-4 py-2 rounded-lg font-medium transition-colors;
  }
  
  .btn-primary {
    @apply bg-primary-500 text-white hover:bg-primary-600;
  }
  
  .btn-secondary {
    @apply bg-gray-100 text-gray-900 hover:bg-gray-200;
  }
}

/* Utilidades custom */
@layer utilities {
  .text-balance {
    text-wrap: balance;
  }
}
```

## Convenciones de Nomenclatura

### Clases por Funcionalidad

```html
<!-- Layout -->
<div class="container mx-auto px-4">
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <!-- Cards -->
  </div>
</div>

<!-- Componente -->
<article class="p-6 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow">
  <h2 class="text-2xl font-bold text-gray-900 mb-2">Título</h2>
  <p class="text-gray-600 leading-relaxed">Descripción del contenido.</p>
</article>

<!-- Botones -->
<button class="btn btn-primary">
  Acción Principal
</button>

<button class="btn btn-secondary">
  Acción Secundaria
</button>
```

### Responsive Design

```html
<!-- Mobile-first -->
<div class="
  flex
  flex-col
  gap-4
  p-4
  md:flex-row
  md:gap-6
  md:p-6
  lg:gap-8
  lg:p-8
">
  <!-- Content -->
</div>

<!-- Grid responsive -->
<div class="
  grid
  grid-cols-1
  sm:grid-cols-2
  lg:grid-cols-3
  xl:grid-cols-4
  gap-4
">
  <!-- Cards -->
</div>

<!-- Ocultar/Mostrar -->
<div class="hidden md:block">
  Visible en desktop
</div>

<div class="md:hidden">
  Visible en mobile
</div>
```

### Estados

```html
<!-- Hover, Focus, Active -->
<button class="
  bg-primary-500
  hover:bg-primary-600
  active:bg-primary-700
  focus:ring-2
  focus:ring-primary-500
  focus:ring-offset-2
  transition-colors
">
  Botón
</button>

<!-- Disabled -->
<button class="
  bg-gray-300
  text-gray-500
  cursor-not-allowed
" disabled>
  Deshabilitado
</button>
```

## Patrones Comunes

### Card Component

```html
<article class="group bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-all">
  <div class="aspect-video bg-gray-200 overflow-hidden">
    <img 
      src="image.jpg" 
      alt="Descripción"
      class="w-full h-full object-cover group-hover:scale-105 transition-transform"
    />
  </div>
  
  <div class="p-6">
    <h3 class="text-xl font-bold text-gray-900 mb-2">
      Título de la Card
    </h3>
    <p class="text-gray-600 mb-4 line-clamp-2">
      Descripción breve del contenido de la card.
    </p>
    <a href="#" class="text-primary-500 font-medium hover:text-primary-600">
      Leer más →
    </a>
  </div>
</article>
```

### Navigation

```html
<nav class="bg-white border-b border-gray-200">
  <div class="container mx-auto px-4">
    <div class="flex items-center justify-between h-16">
      <!-- Logo -->
      <a href="/" class="text-xl font-bold text-gray-900">
        Logo
      </a>
      
      <!-- Desktop Menu -->
      <ul class="hidden md:flex items-center gap-6">
        <li><a href="#" class="text-gray-600 hover:text-gray-900">Inicio</a></li>
        <li><a href="#" class="text-gray-600 hover:text-gray-900">Servicios</a></li>
        <li><a href="#" class="text-gray-600 hover:text-gray-900">Contacto</a></li>
      </ul>
      
      <!-- Mobile Menu Button -->
      <button class="md:hidden p-2">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
    </div>
  </div>
</nav>
```

### Form

```html
<form class="max-w-md mx-auto space-y-6">
  <div>
    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
      Email
    </label>
    <input 
      type="email" 
      id="email"
      class="
        w-full
        px-4
        py-2
        border
        border-gray-300
        rounded-lg
        focus:ring-2
        focus:ring-primary-500
        focus:border-primary-500
        transition-colors
      "
      placeholder="tu@email.com"
    />
  </div>
  
  <button type="submit" class="w-full btn btn-primary">
    Enviar
  </button>
</form>
```

## Dark Mode

```css
/* global.css */
@theme {
  --color-dark-bg: #0f172a;
  --color-dark-surface: #1e293b;
  --color-dark-text: #f1f5f9;
}

@layer base {
  html.dark body {
    @apply bg-dark-bg text-dark-text;
  }
}
```

```html
<!-- Activar dark mode -->
<html class="dark">
  <!-- Contenido con dark mode -->
</html>

<!-- Componentes con dark mode -->
<div class="bg-white dark:bg-dark-surface text-gray-900 dark:text-dark-text">
  Contenido adaptable
</div>
```

## Mejores Prácticas

1. **Mobile-first**: Escribe estilos para mobile primero, luego añade responsive
2. **Design Tokens**: Usa CSS variables para valores reutilizables
3. **Componentes**: Crea componentes en `@layer components`
4. **Utilidades**: Prioriza clases utilitarias sobre CSS custom
5. **Performance**: El purge elimina CSS no usado automáticamente
6. **Accesibilidad**: Incluye estados focus y hover
7. **Semántica**: Combina Tailwind con HTML semántico

## Integración con Astro

```astro
---
// Layout.astro
import '../styles/global.css'
---

<html>
  <body class="bg-white text-gray-900">
    <slot />
  </body>
</html>
```

```astro
---
// Componente.astro
interface Props {
  variant?: 'primary' | 'secondary'
}

const { variant = 'primary' } = Astro.props
---

<button class:list={[
  'btn',
  variant === 'primary' && 'btn-primary',
  variant === 'secondary' && 'btn-secondary'
]}>
  <slot />
</button>
```

## Recursos

- [Documentación oficial](https://tailwindcss.com/docs)
- [Tailwind UI](https://tailwindui.com)
- [Headless UI](https://headlessui.com)
- [Tailwind CSS v4](https://tailwindcss.com/blog/tailwindcss-v4-alpha)

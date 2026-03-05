#!/bin/bash

# Setup script for web-astro-opencode-template
# This script initializes a new project based on this template

set -e

echo "🚀 Iniciando setup del proyecto web-astro-opencode-template..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if we're in a git repository
if [ ! -d .git ]; then
    print_warning "No estamos en un repositorio git. Inicializando..."
    git init
    print_success "Repositorio git inicializado"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor, instala Node.js primero."
    exit 1
fi

print_success "Node.js detectado: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm no está instalado. Por favor, instala npm primero."
    exit 1
fi

print_success "npm detectado: $(npm --version)"

# Check if opencode is installed
if ! command -v opencode &> /dev/null; then
    print_warning "OpenCode no está instalado."
    print_info "Puedes instalarlo con: npm install -g @opencode/cli"
    print_info "Continuando con la instalación de dependencias..."
fi

# Step 1: Install dependencies
print_info "Instalando dependencias..."
npm install
print_success "Dependencias instaladas"

# Step 2: Create Astro project
print_info "Creando proyecto Astro..."
if [ ! -f "package.json" ]; then
    print_warning "No se encontró package.json. Ejecutando create astro..."
    npm create astro@latest ./ -- --template minimal --typescript strict --install --git
else
    print_success "package.json ya existe, saltando creación de Astro"
fi

# Step 3: Install Prettier
print_info "Instalando Prettier..."
npm install --save-dev prettier prettier-plugin-astro
print_success "Prettier instalado"

# Step 4: Add Tailwind CSS
print_info "Añadiendo Tailwind CSS..."
if ! grep -q "tailwindcss" package.json 2>/dev/null; then
    npx astro add tailwind --yes
    print_success "Tailwind CSS añadido"
else
    print_success "Tailwind CSS ya está instalado"
fi

# Step 5: Create necessary directories
print_info "Creando estructura de directorios..."
mkdir -p src/components/ui
mkdir -p src/components/features
mkdir -p src/layouts
mkdir -p src/pages
mkdir -p src/styles
mkdir -p src/config
mkdir -p public
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p tests/e2e
mkdir -p tests/fixtures
mkdir -p tests/utils
print_success "Directorios creados"

# Step 6: Create config files if they don't exist
print_info "Creando archivos de configuración..."

# Create site config if it doesn't exist
if [ ! -f "src/config/site.ts" ]; then
    cat > src/config/site.ts << 'EOF'
/**
 * Configuración centralizada del sitio.
 * Edita estos valores para personalizar tu proyecto.
 */
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
EOF
    print_success "src/config/site.ts creado"
fi

# Create global styles if they don't exist
if [ ! -f "src/styles/global.css" ]; then
    cat > src/styles/global.css << 'EOF'
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
}

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

@layer utilities {
  .text-balance {
    text-wrap: balance;
  }
}
EOF
    print_success "src/styles/global.css creado"
fi

# Create Layout if it doesn't exist
if [ ! -f "src/layouts/Layout.astro" ]; then
    cat > src/layouts/Layout.astro << 'EOF'
---
import { siteConfig } from '../config/site'
import '../styles/global.css'

interface Props {
  title: string
  description?: string
  image?: string
}

const { 
  title, 
  description = siteConfig.tagline,
  image = '/og-image.jpg'
} = Astro.props

const fullTitle = `${title} | ${siteConfig.name}`
const canonicalURL = Astro.url.href
const fullImageUrl = new URL(image, siteConfig.url).href
---

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- SEO -->
    <title>{fullTitle}</title>
    <meta name="description" content={description} />
    <link rel="canonical" href={canonicalURL} />
    
    <!-- Open Graph -->
    <meta property="og:type" content="website" />
    <meta property="og:url" content={canonicalURL} />
    <meta property="og:title" content={fullTitle} />
    <meta property="og:description" content={description} />
    <meta property="og:image" content={fullImageUrl} />
    
    <!-- Twitter -->
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content={fullTitle} />
    <meta name="twitter:description" content={description} />
    <meta name="twitter:image" content={fullImageUrl} />
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
  </head>
  <body class="bg-white text-gray-900">
    <slot />
  </body>
</html>
EOF
    print_success "src/layouts/Layout.astro creado"
fi

# Create index page if it doesn't exist
if [ ! -f "src/pages/index.astro" ]; then
    cat > src/pages/index.astro << 'EOF'
---
import Layout from '../layouts/Layout.astro'
import { siteConfig } from '../config/site'
---

<Layout title="Inicio">
  <main class="container mx-auto px-4 py-12">
    <div class="max-w-4xl mx-auto text-center">
      <h1 class="text-5xl font-bold text-gray-900 mb-6">
        Bienvenido a {siteConfig.name}
      </h1>
      <p class="text-xl text-gray-600 mb-8">
        {siteConfig.tagline}
      </p>
      <button class="btn btn-primary">
        Empezar
      </button>
    </div>
  </main>
</Layout>
EOF
    print_success "src/pages/index.astro creado"
fi

# Create robots.txt if it doesn't exist
if [ ! -f "public/robots.txt" ]; then
    cat > public/robots.txt << 'EOF'
User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml
EOF
    print_success "public/robots.txt creado"
fi

# Create favicon if it doesn't exist
if [ ! -f "public/favicon.svg" ]; then
    cat > public/favicon.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" fill="none">
  <rect width="32" height="32" rx="8" fill="#3b82f6"/>
  <text x="50%" y="50%" dominant-baseline="central" text-anchor="middle" font-size="20" fill="white">🚀</text>
</svg>
EOF
    print_success "public/favicon.svg creado"
fi

# Step 7: Create AGENTS.md from example
if [ ! -f "AGENTS.md" ]; then
    if [ -f "AGENTS.md.example" ]; then
        cp AGENTS.md.example AGENTS.md
        print_success "AGENTS.md creado desde AGENTS.md.example"
    fi
fi

# Step 8: Initialize OpenCode if available
if command -v opencode &> /dev/null; then
    print_info "Inicializando OpenCode..."
    opencode init
    print_success "OpenCode inicializado"
else
    print_warning "OpenCode no está instalado. Saltando inicialización."
    print_info "Instala OpenCode con: npm install -g @opencode/cli"
fi

# Step 9: Create initial git commit if needed
if [ -z "$(git status --porcelain)" ]; then
    print_info "Repositorio limpio, no se necesitan commits."
else
    print_info "Creando commit inicial..."
    git add .
    git commit -m "Initial commit: Setup web-astro-opencode-template"
    print_success "Commit inicial creado"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ ¡Setup completado exitosamente!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Próximos pasos:"
echo ""
echo "  1. Personaliza src/config/site.ts con tu información"
echo "  2. Edita AGENTS.md con el nombre y descripción de tu proyecto"
echo "  3. Inicia el servidor de desarrollo: npm run dev"
echo "  4. Abre OpenCode: opencode"
echo ""
echo "Comandos útiles:"
echo ""
echo "  npm run dev       # Servidor de desarrollo"
echo "  npm run build     # Build de producción"
echo "  opencode          # Iniciar OpenCode"
echo "  opencode -c       # Continuar sesión anterior"
echo ""
echo "¡Feliz desarrollo! 🚀"

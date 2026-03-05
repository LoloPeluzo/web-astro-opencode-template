---
name: testing-specialist
description: Especialista en testing para aplicaciones web: unitario, integración y E2E con Playwright. Usa este skill cuando necesites crear o mejorar tests automatizados.
---

# Especialista en Testing

## Descripción

Proporciona asistencia experta en testing de aplicaciones web, incluyendo:

- **Testing Unitario**: Tests de funciones y componentes aislados
- **Testing de Integración**: Tests de flujos entre componentes
- **Testing E2E**: Tests de extremo a extremo con Playwright
- **Visual Regression**: Tests de regresión visual
- **Performance Testing**: Tests de rendimiento
- **Accessibility Testing**: Tests de accesibilidad automatizados

## Cuándo usar este skill

Invoca `@testing-specialist` cuando necesites:

- Crear tests unitarios
- Implementar tests E2E
- Configurar Playwright
- Crear tests de integración
- Implementar CI/CD con tests
- Debuggear tests fallidos
- Mejorar cobertura de tests

## Estructura de Proyecto

```
tests/
├── unit/              # Tests unitarios
│   └── utils.test.ts
├── integration/       # Tests de integración
│   └── api.test.ts
├── e2e/               # Tests E2E con Playwright
│   ├── homepage.spec.ts
│   └── contact.spec.ts
├── fixtures/          # Datos de prueba
│   └── users.ts
└── utils/             # Utilidades de testing
    └── test-helpers.ts

playwright.config.ts   # Configuración de Playwright
vitest.config.ts       # Configuración de Vitest
```

## 1. Configuración

### Playwright Setup

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  
  use: {
    baseURL: 'http://localhost:4321',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:4321',
    reuseExistingServer: !process.env.CI,
  },
})
```

### Vitest Setup

```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'tests/',
      ],
    },
  },
})
```

## 2. Testing E2E con Playwright

### Test Básico

```typescript
// tests/e2e/homepage.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Homepage', () => {
  test('should display hero section', async ({ page }) => {
    await page.goto('/')
    
    // Verificar que el título está visible
    await expect(page.locator('h1')).toBeVisible()
    await expect(page.locator('h1')).toContainText('Bienvenido')
    
    // Verificar que el CTA funciona
    const ctaButton = page.getByRole('button', { name: /empezar/i })
    await expect(ctaButton).toBeEnabled()
  })
  
  test('should navigate to about page', async ({ page }) => {
    await page.goto('/')
    
    // Click en enlace de About
    await page.click('text=About')
    
    // Verificar URL
    await expect(page).toHaveURL('/about')
    
    // Verificar contenido
    await expect(page.locator('h1')).toContainText('About')
  })
})
```

### Page Object Model (POM)

```typescript
// tests/e2e/pages/HomePage.ts
import { Page, Locator } from '@playwright/test'

export class HomePage {
  readonly page: Page
  readonly heroTitle: Locator
  readonly ctaButton: Locator
  readonly navigation: Locator

  constructor(page: Page) {
    this.page = page
    this.heroTitle = page.locator('h1')
    this.ctaButton = page.getByRole('button', { name: /empezar/i })
    this.navigation = page.locator('nav')
  }

  async goto() {
    await this.page.goto('/')
  }

  async clickCTA() {
    await this.ctaButton.click()
  }

  async navigateTo(page: string) {
    await this.navigation.click(`text=${page}`)
  }
}
```

```typescript
// tests/e2e/homepage-pom.spec.ts
import { test, expect } from '@playwright/test'
import { HomePage } from './pages/HomePage'

test.describe('Homepage with POM', () => {
  let homePage: HomePage

  test.beforeEach(async ({ page }) => {
    homePage = new HomePage(page)
    await homePage.goto()
  })

  test('should display hero section', async () => {
    await expect(homePage.heroTitle).toBeVisible()
    await expect(homePage.ctaButton).toBeEnabled()
  })

  test('should navigate to about', async () => {
    await homePage.navigateTo('About')
    await expect(homePage.page).toHaveURL('/about')
  })
})
```

### Form Testing

```typescript
// tests/e2e/contact.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Contact Form', () => {
  test('should submit contact form successfully', async ({ page }) => {
    await page.goto('/contact')
    
    // Rellenar formulario
    await page.fill('#name', 'John Doe')
    await page.fill('#email', 'john@example.com')
    await page.fill('#message', 'Este es un mensaje de prueba')
    
    // Enviar formulario
    await page.click('button[type="submit"]')
    
    // Verificar mensaje de éxito
    await expect(page.locator('.success-message')).toBeVisible()
    await expect(page.locator('.success-message')).toContainText('Mensaje enviado')
  })
  
  test('should show validation errors', async ({ page }) => {
    await page.goto('/contact')
    
    // Intentar enviar formulario vacío
    await page.click('button[type="submit"]')
    
    // Verificar errores de validación
    await expect(page.locator('#name-error')).toContainText('Nombre requerido')
    await expect(page.locator('#email-error')).toContainText('Email requerido')
  })
})
```

### Visual Regression Testing

```typescript
// tests/e2e/visual.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Visual Regression', () => {
  test('homepage should match snapshot', async ({ page }) => {
    await page.goto('/')
    
    // Esperar a que cargue completamente
    await page.waitForLoadState('networkidle')
    
    // Comparar con snapshot
    await expect(page).toHaveScreenshot('homepage.png', {
      maxDiffPixels: 100,
    })
  })
  
  test('component should match snapshot', async ({ page }) => {
    await page.goto('/')
    
    const hero = page.locator('.hero-section')
    await expect(hero).toHaveScreenshot('hero-component.png')
  })
})
```

### Accessibility Testing

```typescript
// tests/e2e/accessibility.spec.ts
import { test, expect } from '@playwright/test'
import AxeBuilder from '@axe-core/playwright'

test.describe('Accessibility', () => {
  test('should not have accessibility violations on homepage', async ({ page }) => {
    await page.goto('/')
    
    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
      .analyze()
    
    expect(accessibilityScanResults.violations).toEqual([])
  })
  
  test('should have proper heading hierarchy', async ({ page }) => {
    await page.goto('/')
    
    // Verificar que existe h1
    const h1 = page.locator('h1')
    await expect(h1).toHaveCount(1)
    
    // Verificar que no se salta niveles de heading
    const headings = await page.locator('h1, h2, h3, h4, h5, h6').all()
    let previousLevel = 0
    
    for (const heading of headings) {
      const tagName = await heading.evaluate(el => el.tagName)
      const currentLevel = parseInt(tagName.charAt(1))
      
      expect(currentLevel).toBeLessThanOrEqual(previousLevel + 1)
      previousLevel = currentLevel
    }
  })
})
```

## 3. Testing Unitario con Vitest

### Test de Funciones

```typescript
// src/utils/format.ts
export function formatCurrency(amount: number, currency: string = 'EUR'): string {
  return new Intl.NumberFormat('es-ES', {
    style: 'currency',
    currency,
  }).format(amount)
}

export function formatDate(date: Date): string {
  return new Intl.DateTimeFormat('es-ES', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date)
}
```

```typescript
// tests/unit/format.test.ts
import { describe, it, expect } from 'vitest'
import { formatCurrency, formatDate } from '../../src/utils/format'

describe('formatCurrency', () => {
  it('should format EUR currency correctly', () => {
    expect(formatCurrency(1234.56)).toBe('1.234,56 €')
  })
  
  it('should format USD currency correctly', () => {
    expect(formatCurrency(1234.56, 'USD')).toBe('1.234,56 US$')
  })
  
  it('should handle zero', () => {
    expect(formatCurrency(0)).toBe('0,00 €')
  })
  
  it('should handle negative numbers', () => {
    expect(formatCurrency(-100)).toBe('-100,00 €')
  })
})

describe('formatDate', () => {
  it('should format date in Spanish', () => {
    const date = new Date('2026-03-05')
    expect(formatDate(date)).toBe('5 de marzo de 2026')
  })
})
```

### Test de Componentes Astro

```typescript
// tests/unit/Button.test.ts
import { describe, it, expect } from 'vitest'
import { renderToString } from 'astro/runtime/server/render/index.js'
import Button from '../../src/components/Button.astro'

describe('Button Component', () => {
  it('should render with default props', async () => {
    const html = await renderToString(Button, {
      props: {},
      slots: { default: 'Click me' },
    })
    
    expect(html).toContain('Click me')
    expect(html).toContain('btn-primary')
  })
  
  it('should render with custom variant', async () => {
    const html = await renderToString(Button, {
      props: { variant: 'secondary' },
      slots: { default: 'Click me' },
    })
    
    expect(html).toContain('btn-secondary')
  })
})
```

## 4. Testing de Integración

### API Testing

```typescript
// tests/integration/api.test.ts
import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { astro } from 'astro'

describe('API Endpoints', () => {
  let server: any

  beforeAll(async () => {
    server = await astro.start({
      root: './',
      mode: 'test',
    })
  })

  afterAll(async () => {
    await server.stop()
  })

  it('should return users from API', async () => {
    const response = await fetch('http://localhost:4321/api/users')
    const data = await response.json()
    
    expect(response.status).toBe(200)
    expect(Array.isArray(data)).toBe(true)
  })

  it('should create a new user', async () => {
    const response = await fetch('http://localhost:4321/api/users', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        name: 'John Doe',
        email: 'john@example.com',
      }),
    })
    
    const data = await response.json()
    
    expect(response.status).toBe(201)
    expect(data.name).toBe('John Doe')
  })
})
```

## 5. CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run unit tests
        run: npm run test:unit
      
      - name: Install Playwright browsers
        run: npx playwright install --with-deps
      
      - name: Run E2E tests
        run: npm run test:e2e
      
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: playwright-report
          path: playwright-report/
          retention-days: 30
```

## 6. Mejores Prácticas

### AAA Pattern (Arrange-Act-Assert)

```typescript
test('should calculate total price', async ({ page }) => {
  // Arrange: Preparar el estado inicial
  await page.goto('/cart')
  await page.fill('#quantity', '2')
  
  // Act: Ejecutar la acción
  await page.click('#calculate-total')
  
  // Assert: Verificar el resultado
  const total = await page.locator('#total-price').textContent()
  expect(total).toBe('€200.00')
})
```

### Test Isolation

```typescript
test.describe('User Management', () => {
  // Cada test es independiente
  test.beforeEach(async ({ page }) => {
    // Resetear estado antes de cada test
    await page.goto('/')
    await page.evaluate(() => localStorage.clear())
  })
  
  test('should create user', async ({ page }) => {
    // Test aislado
  })
  
  test('should delete user', async ({ page }) => {
    // Test aislado
  })
})
```

### Meaningful Test Names

```typescript
// ✅ Bueno: Describe el comportamiento
test('should display error message when email is invalid', async ({ page }) => {
  // ...
})

// ❌ Malo: No describe el comportamiento
test('test email', async ({ page }) => {
  // ...
})
```

## Comandos de Testing

```bash
# Tests unitarios
npm run test:unit

# Tests E2E
npm run test:e2e

# Tests con UI de Playwright
npm run test:e2e:ui

# Tests en modo debug
npm run test:e2e:debug

# Tests de un archivo específico
npx playwright test tests/e2e/homepage.spec.ts

# Tests en un navegador específico
npx playwright test --project=chromium

# Ver reporte de Playwright
npx playwright show-report
```

## Recursos

- [Playwright Documentation](https://playwright.dev)
- [Vitest Documentation](https://vitest.dev)
- [Testing Library](https://testing-library.com)
- [Cypress vs Playwright](https://playwright.dev/docs/cypress)
- [Testing Trophy](https://kentcdodds.com/blog/the-testing-trophy-and-testing-classifications)

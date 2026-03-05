# Guía de Creación de Skills

Esta guía te ayudará a crear skills personalizadas para tu proyecto OpenCode.

## ¿Qué es una Skill?

Una skill es un archivo de documentación que proporciona instrucciones especializadas a OpenCode sobre cómo trabajar en un área específica de tu proyecto. Las skills permiten que los agentes de OpenCode tengan conocimiento experto en diferentes dominios.

## Estructura de una Skill

Las skills se almacenan en `.opencode/skills/<nombre>/SKILL.md` y tienen el siguiente formato:

```markdown
---
name: nombre-de-skill
description: Descripción breve de qué hace esta skill y cuándo usarla.
---

# Título de la Skill

## Descripción

Descripción detallada de qué proporciona esta skill.

## Cuándo usar este skill

Lista de situaciones en las que invocar esta skill.

## Contenido específico

Instrucciones, patrones, ejemplos de código, mejores prácticas, etc.

## Recursos

Enlaces a documentación externa, herramientas, etc.
```

## Reglas de Nomenclatura

- Solo minúsculas alfanuméricas
- Guiones simples para separar palabras
- No puede empezar o terminar con guión
- No puede tener guiones consecutivos (`--`)
- Debe coincidir con el nombre del directorio

✅ **Ejemplos válidos:**
- `astro-specialist`
- `tailwind-specialist`
- `web-quality`
- `testing-specialist`

❌ **Ejemplos inválidos:**
- `Astro-Specialist` (mayúsculas)
- `astro_specialist` (guiones bajos)
- `astro--specialist` (doble guión)
- `-astro-specialist` (empieza con guión)

## Crear una Skill Nueva

### Paso 1: Crear el Directorio

```bash
mkdir -p .opencode/skills/mi-skill
```

### Paso 2: Crear el Archivo SKILL.md

```bash
touch .opencode/skills/mi-skill/SKILL.md
```

### Paso 3: Escribir el Contenido

```markdown
---
name: mi-skill
description: Descripción de mi skill personalizada.
---

# Mi Skill Personalizada

## Descripción

Esta skill proporciona asistencia en...

## Cuándo usar este skill

Invoca `@mi-skill` cuando necesites:

- Tarea 1
- Tarea 2
- Tarea 3

## Patrones y Ejemplos

### Ejemplo 1

```typescript
// Código de ejemplo
```

### Ejemplo 2

```astro
<!-- Código de ejemplo -->
```

## Mejores Prácticas

1. Mejor práctica 1
2. Mejor práctica 2
3. Mejor práctica 3

## Recursos

- [Recurso 1](https://ejemplo.com)
- [Recurso 2](https://ejemplo.com)
```

### Paso 4: Registrar en opencode.json

Añade la skill al archivo `opencode.json`:

```json
{
  "skills": {
    "mi-skill": {
      "description": "Descripción de mi skill personalizada",
      "path": "./.opencode/skills/mi-skill/SKILL.md"
    }
  }
}
```

## Tipos de Skills Recomendadas

### 1. Skills de Framework

Especializadas en frameworks específicos:
- `react-specialist`
- `vue-specialist`
- `svelte-specialist`
- `nextjs-specialist`

### 2. Skills de Herramientas

Para herramientas específicas:
- `testing-specialist`
- `git-specialist`
- `docker-specialist`
- `ci-cd-specialist`

### 3. Skills de Dominio

Para áreas específicas del negocio:
- `ecommerce-specialist`
- `blog-specialist`
- `dashboard-specialist`
- `api-specialist`

### 4. Skills de Calidad

Para aspectos de calidad:
- `accessibility-specialist`
- `performance-specialist`
- `security-specialist`
- `seo-specialist`

## Mejores Prácticas

### 1. Ser Específico

Cada skill debe tener un propósito claro y específico:

```markdown
---
name: form-validation
description: Especialista en validación de formularios con Zod y React Hook Form.
---
```

### 2. Proporcionar Ejemplos

Incluye ejemplos de código concretos:

```markdown
## Ejemplo de Uso

```typescript
import { z } from 'zod'

const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
})
```
```

### 3. Documentar Patrones

Incluye patrones comunes y anti-patrones:

```markdown
## Patrones Recomendados

### ✅ Patrón Correcto

```typescript
// Código correcto
```

### ❌ Anti-Patrón

```typescript
// Código incorrecto
```
```

### 4. Incluir Recursos

Añade enlaces a documentación externa:

```markdown
## Recursos

- [Documentación oficial](https://ejemplo.com)
- [Tutorial](https://ejemplo.com/tutorial)
- [Mejores prácticas](https://ejemplo.com/best-practices)
```

### 5. Mantener Actualizado

Revisa y actualiza las skills regularmente para mantenerlas relevantes.

## Ejemplo Completo

```markdown
---
name: api-client
description: Especialista en creación de clientes API con fetch y TypeScript.
---

# API Client Specialist

## Descripción

Proporciona asistencia en la creación de clientes API robustos con TypeScript, incluyendo:
- Configuración de fetch
- Manejo de errores
- Tipado de responses
- Autenticación

## Cuándo usar este skill

Invoca `@api-client` cuando necesites:
- Crear un nuevo endpoint
- Manejar errores de API
- Implementar autenticación
- Tipar responses

## Configuración Base

```typescript
// src/lib/api-client.ts
const API_BASE_URL = import.meta.env.API_URL

interface RequestOptions extends RequestInit {
  params?: Record<string, string>
}

class ApiClient {
  private baseUrl: string

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl
  }

  async get<T>(endpoint: string, options?: RequestOptions): Promise<T> {
    const url = new URL(endpoint, this.baseUrl)
    
    if (options?.params) {
      Object.entries(options.params).forEach(([key, value]) => {
        url.searchParams.append(key, value)
      })
    }

    const response = await fetch(url.toString(), {
      ...options,
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
    })

    if (!response.ok) {
      throw new Error(`API Error: ${response.status}`)
    }

    return response.json()
  }
}

export const api = new ApiClient(API_BASE_URL)
```

## Uso

```typescript
// src/services/users.ts
import { api } from '../lib/api-client'

interface User {
  id: string
  name: string
  email: string
}

export async function getUsers() {
  return api.get<User[]>('/users')
}
```

## Mejores Prácticas

1. **Siempre tipar responses**: Usa interfaces para tipar las responses
2. **Manejar errores**: Implementa manejo de errores consistente
3. **Centralizar configuración**: Usa una instancia centralizada del cliente
4. **Validar responses**: Usa Zod para validar responses en runtime

## Recursos

- [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Zod](https://zod.dev/)
```

## Invocar Skills

Para usar una skill en OpenCode:

```
@api-client necesito crear un endpoint para obtener productos
```

OpenCode cargará automáticamente la skill y usará el conocimiento especializado para ayudarte.

## Compartir Skills

Para compartir skills entre proyectos:

1. **Crear repositorio**: Crea un repositorio con tus skills
2. **Documentar**: Añade README con instrucciones
3. **Versionar**: Usa tags para versionar las skills
4. **Instalar**: Otros pueden clonar o copiar las skills

## Debuggear Skills

Si una skill no se carga correctamente:

1. Verifica el nombre del directorio coincide con el `name` en el frontmatter
2. Verifica la ruta en `opencode.json`
3. Verifica la sintaxis del archivo SKILL.md
4. Usa `/debug` en OpenCode para ver logs

## Conclusión

Las skills son una forma poderosa de proporcionar conocimiento especializado a OpenCode. Sigue estas guías para crear skills efectivas que mejoren tu flujo de desarrollo.

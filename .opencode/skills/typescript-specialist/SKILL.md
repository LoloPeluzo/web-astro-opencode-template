---
name: typescript-specialist
description: Especialista en TypeScript para aplicaciones robustas. Usa este skill cuando trabajes con tipos avanzados, interfaces, generics o mejores prácticas de TypeScript.
---

# Especialista en TypeScript

## Descripción

Proporciona asistencia experta en TypeScript, incluyendo:

- **Tipos Avanzados**: Generics, conditional types, mapped types
- **Interfaces y Types**: Modelado de datos y contratos
- **Type Safety**: Configuración strict y mejores prácticas
- **Utilidades**: Type guards, utility types
- **Patrones**: Diseño con tipos, inferencia
- **Integración**: TypeScript con Astro, React, Node

## Cuándo usar este skill

Invoca `@typescript-specialist` cuando necesites:

- Crear interfaces o types
- Implementar generics
- Configurar tsconfig.json
- Resolver errores de tipos
- Crear utilidades de tipos
- Mejorar type safety
- Refactorizar código con tipos

## Configuración Strict

```json
// tsconfig.json
{
  "extends": "astro/tsconfigs/strict",
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

## Patrones Comunes

### Interfaces vs Types

```typescript
// Interface: para objetos que pueden extenderse
interface User {
  id: string
  name: string
  email: string
  role: 'admin' | 'user' | 'guest'
}

interface UserWithAvatar extends User {
  avatar?: string
}

// Type: para uniones, intersecciones, utilidades
type Status = 'pending' | 'approved' | 'rejected'
type UserRole = User['role'] // 'admin' | 'user' | 'guest'

// Intersección
type UserWithStatus = User & { status: Status }
```

### Generics

```typescript
// Función genérica
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key]
}

const user: User = { id: '1', name: 'John', email: 'john@example.com', role: 'admin' }
const userName = getProperty(user, 'name') // string

// Interface genérica
interface ApiResponse<T> {
  data: T
  status: number
  message: string
}

type UserResponse = ApiResponse<User>
type UsersResponse = ApiResponse<User[]>
```

### Utility Types

```typescript
// Partial: todas las propiedades opcionales
type PartialUser = Partial<User>

// Required: todas las propiedades requeridas
type RequiredUser = Required<User>

// Pick: seleccionar propiedades
type UserPreview = Pick<User, 'id' | 'name'>

// Omit: omitir propiedades
type UserWithoutEmail = Omit<User, 'email'>

// Record: objeto con keys y values
type UserRoles = Record<string, UserRole>

// Readonly: propiedades de solo lectura
type ReadonlyUser = Readonly<User>

// ReturnType: tipo de retorno de función
function createUser() {
  return { id: '1', name: 'John' }
}
type CreatedUser = ReturnType<typeof createUser>
```

### Type Guards

```typescript
// Type guard con typeof
function isString(value: unknown): value is string {
  return typeof value === 'string'
}

// Type guard con in
function hasEmail(user: unknown): user is { email: string } {
  return typeof user === 'object' && user !== null && 'email' in user
}

// Type guard con instanceof
class ApiError extends Error {
  constructor(public statusCode: number, message: string) {
    super(message)
  }
}

function isApiError(error: unknown): error is ApiError {
  return error instanceof ApiError
}

// Uso
function handleError(error: unknown) {
  if (isApiError(error)) {
    console.log(`API Error ${error.statusCode}: ${error.message}`)
  } else if (error instanceof Error) {
    console.log(`Error: ${error.message}`)
  }
}
```

### Conditional Types

```typescript
// Tipo condicional básico
type NonNullable<T> = T extends null | undefined ? never : T

// Distributive conditional types
type ToArray<T> = T extends unknown ? T[] : never
type StrArr = ToArray<string> // string[]

// Inferencia en tipos condicionales
type UnwrapPromise<T> = T extends Promise<infer U> ? U : T
type Unwrapped = UnwrapPromise<Promise<string>> // string

// Tipo condicional para API responses
type ApiResponse<T> = T extends { error: string }
  ? { success: false; error: string }
  : { success: true; data: T }
```

### Mapped Types

```typescript
// Mapped type básico
type Readonly<T> = {
  readonly [K in keyof T]: T[K]
}

// Mapped type con modificación
type Optional<T> = {
  [K in keyof T]?: T[K]
}

// Mapped type con renombrado
type Getters<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K]
}

interface User {
  id: string
  name: string
}

type UserGetters = Getters<User>
// { getId: () => string, getName: () => string }
```

## Patrones con Astro

### Props de Componentes

```astro
---
// Component.astro
interface Props {
  title: string
  description?: string
  variant?: 'primary' | 'secondary'
  size?: 'sm' | 'md' | 'lg'
}

const { 
  title, 
  description, 
  variant = 'primary',
  size = 'md' 
} = Astro.props
---

<div class:list={[
  'component',
  variant,
  size
]}>
  <h2>{title}</h2>
  {description && <p>{description}</p>}
</div>
```

### Configuración Tipada

```typescript
// src/config/site.ts
export interface SiteConfig {
  name: string
  tagline: string
  url: string
  email: string
  phone?: string
  social?: {
    instagram?: string
    facebook?: string
    twitter?: string
    linkedin?: string
  }
  analyticsId?: string
}

export const siteConfig: SiteConfig = {
  name: 'Mi Proyecto',
  tagline: 'Descripción breve del proyecto',
  url: 'https://example.com',
  email: 'contacto@example.com',
  social: {
    instagram: 'https://instagram.com/miproyecto',
  },
  analyticsId: 'G-XXXXXXXXXX',
}
```

### API Types

```typescript
// src/types/api.ts
export interface ApiResponse<T> {
  data: T
  status: number
  message: string
}

export interface PaginatedResponse<T> {
  data: T[]
  total: number
  page: number
  perPage: number
  totalPages: number
}

export interface ApiError {
  statusCode: number
  message: string
  details?: Record<string, string[]>
}
```

### Content Collections (Astro)

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content'

const blogCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    author: z.string().default('Anonymous'),
    tags: z.array(z.string()).default([]),
    image: z.string().optional(),
  }),
})

export const collections = {
  blog: blogCollection,
}
```

## Mejores Prácticas

1. **Strict Mode**: Siempre usar `strict: true`
2. **Explicit Types**: Tipar funciones y variables explícitamente
3. **No Any**: Evitar `any`, usar `unknown` cuando sea necesario
4. **Readonly**: Usar readonly para inmutabilidad
5. **Type Guards**: Crear type guards para validación en runtime
6. **Utility Types**: Aprovechar los tipos utilitarios de TypeScript
7. **Naming**: Usar nombres descriptivos para interfaces y types

## Errores Comunes

### 1. Uso de Any

```typescript
// ❌ Mal
function processData(data: any) {
  return data.value
}

// ✅ Bien
function processData<T extends { value: unknown }>(data: T) {
  return data.value
}

// ✅ Mejor aún
function processData(data: { value: string }): string {
  return data.value
}
```

### 2. Asignaciones Inseguras

```typescript
// ❌ Mal
const user = JSON.parse(jsonString) as User

// ✅ Bien
import { z } from 'zod'

const UserSchema = z.object({
  id: z.string(),
  name: z.string(),
  email: z.string().email(),
})

const result = UserSchema.safeParse(JSON.parse(jsonString))
if (result.success) {
  const user: User = result.data
} else {
  console.error(result.error)
}
```

### 3. Index Signatures

```typescript
// ❌ Mal
interface Config {
  [key: string]: any
}

// ✅ Bien
interface Config {
  apiUrl: string
  timeout: number
  retries: number
}

// ✅ Si necesitas flexibilidad
type Config = Record<string, string | number | boolean>
```

## Recursos

- [Documentación oficial](https://www.typescriptlang.org/docs)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript)
- [Total TypeScript](https://totaltypescript.com)
- [TypeScript Exercises](https://typescript-exercises.github.io)

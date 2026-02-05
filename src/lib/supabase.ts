import { createClient } from '@supabase/supabase-js'
import type { Database } from '@/types/supabase'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || ''
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''

if (!supabaseUrl || !supabaseAnonKey) {
  // No detener la ejecución; solo advertir para desarrollo local
  // Esto evita que la app se rompa si las vars no están definidas
  // o el proyecto de Supabase no está disponible.
  // Las llamadas de red seguirán fallar, pero evitamos reintentos automáticos.
  // Revisa .env.local y pon las variables `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
  // eslint-disable-next-line no-console
  console.warn('Supabase: faltan NEXT_PUBLIC_SUPABASE_URL o NEXT_PUBLIC_SUPABASE_ANON_KEY. Algunas funciones estarán limitadas.')
}

// Desactivar auto-refresh y persistencia para evitar bucles de reintentos cuando
// el endpoint de auth no responde o el DNS no resuelve (útil en desarrollo).
const supabaseOptions = {
  auth: {
    persistSession: false,
    autoRefreshToken: false,
  },
}

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, supabaseOptions)

// Cliente con autenticación automática para componentes del lado del servidor
export const createServerSupabaseClient = () => {
  return createClient<Database>(supabaseUrl, supabaseAnonKey, supabaseOptions)
}

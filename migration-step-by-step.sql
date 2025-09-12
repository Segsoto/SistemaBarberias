-- ===================================================================
-- MIGRACIÓN PASO A PASO - DIAGNÓSTICO DE PROBLEMAS
-- ===================================================================
-- Ejecuta este script SECCIÓN POR SECCIÓN para identificar dónde está el problema

-- PASO 1: VERIFICAR EXTENSIONES
-- ===================================================================
SELECT 'PASO 1: Verificando extensiones existentes...' as paso;

SELECT 
    extname as extension_name,
    extversion as version,
    'INSTALADA' as status
FROM pg_extension 
WHERE extname IN ('uuid-ossp', 'pgcrypto')
ORDER BY extname;

-- Crear extensiones si no existen
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

SELECT 'Extensiones verificadas/instaladas' as resultado;

-- PASO 2: CREAR TIPOS ENUM
-- ===================================================================
SELECT 'PASO 2: Creando tipos enumerados...' as paso;

CREATE TYPE appointment_status AS ENUM ('programada', 'confirmada', 'cancelada', 'completada');
CREATE TYPE service_type AS ENUM ('corte', 'corte_barba');

-- Verificar tipos creados
SELECT 
    typname as tipo_creado,
    'CREADO' as status
FROM pg_type 
WHERE typname IN ('appointment_status', 'service_type');

-- PASO 3: CREAR TABLA BARBERSHOPS
-- ===================================================================
SELECT 'PASO 3: Creando tabla barbershops...' as paso;

CREATE TABLE IF NOT EXISTS barbershops (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    activo BOOLEAN DEFAULT true,
    hora_apertura TIME DEFAULT '08:00',
    hora_cierre TIME DEFAULT '18:00',
    dias_laborales TEXT[] DEFAULT ARRAY['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'],
    duracion_cita INTEGER DEFAULT 30,
    duracion_corte_barba INTEGER DEFAULT 60,
    precio_corte_adulto DECIMAL(10,2) DEFAULT 5000.00,
    precio_corte_nino DECIMAL(10,2) DEFAULT 3500.00,
    precio_barba DECIMAL(10,2) DEFAULT 3000.00,
    precio_combo DECIMAL(10,2) DEFAULT 8000.00,
    whatsapp_activo BOOLEAN DEFAULT false,
    whatsapp_numero VARCHAR(20),
    tiempo_cancelacion INTEGER DEFAULT 120,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Verificar que se creó
SELECT 'Tabla barbershops creada exitosamente' as resultado;
SELECT tablename, schemaname FROM pg_tables WHERE tablename = 'barbershops';

-- PASO 4: INSERTAR DATO DE PRUEBA
-- ===================================================================
SELECT 'PASO 4: Insertando barbería de prueba...' as paso;

INSERT INTO barbershops (nombre, email, telefono, direccion) 
VALUES ('Barber Test', 'test@barber.com', '+506 1111-1111', 'Test Address')
ON CONFLICT (email) DO NOTHING;

-- Verificar inserción
SELECT 
    'Barbería insertada:' as info,
    nombre,
    email
FROM barbershops 
WHERE email = 'test@barber.com';

-- PASO 5: VERIFICACIÓN FINAL
-- ===================================================================
SELECT 'PASO 5: Verificación final...' as paso;

-- Contar registros
SELECT 
    'TOTAL DE BARBERÍAS:' as info,
    COUNT(*) as cantidad
FROM barbershops;

-- Verificar estructura
SELECT 
    'ESTRUCTURA DE BARBERSHOPS:' as info,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_name = 'barbershops' 
AND table_schema = 'public'
ORDER BY ordinal_position
LIMIT 5;

SELECT 'MIGRACIÓN PASO A PASO COMPLETADA - Si llegaste aquí, la tabla barbershops funciona correctamente' as resultado_final;
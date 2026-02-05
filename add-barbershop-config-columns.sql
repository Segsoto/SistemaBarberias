-- ===================================================================
-- SCRIPT PARA AGREGAR COLUMNAS DE CONFIGURACIÓN A BARBERSHOPS
-- ===================================================================
-- Este script agrega las columnas faltantes para configuración de la barbería

-- Agregar columnas de configuración básica
ALTER TABLE barbershops 
ADD COLUMN IF NOT EXISTS descripcion TEXT,
ADD COLUMN IF NOT EXISTS hora_apertura TIME DEFAULT '08:00:00',
ADD COLUMN IF NOT EXISTS hora_cierre TIME DEFAULT '18:00:00',
ADD COLUMN IF NOT EXISTS dias_laborales TEXT[] DEFAULT ARRAY['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'];

-- Agregar columnas de servicios y duraciones
ALTER TABLE barbershops 
ADD COLUMN IF NOT EXISTS duracion_cita INTEGER DEFAULT 30,
ADD COLUMN IF NOT EXISTS duracion_corte_barba INTEGER DEFAULT 60;

-- Agregar columnas de precios
ALTER TABLE barbershops 
ADD COLUMN IF NOT EXISTS precio_corte_adulto DECIMAL(10,2) DEFAULT 15000.00,
ADD COLUMN IF NOT EXISTS precio_corte_nino DECIMAL(10,2) DEFAULT 10000.00,
ADD COLUMN IF NOT EXISTS precio_barba DECIMAL(10,2) DEFAULT 8000.00,
ADD COLUMN IF NOT EXISTS precio_combo DECIMAL(10,2) DEFAULT 20000.00;

-- Agregar columnas de WhatsApp y configuración
ALTER TABLE barbershops 
ADD COLUMN IF NOT EXISTS whatsapp_activo BOOLEAN DEFAULT true,
ADD COLUMN IF NOT EXISTS whatsapp_numero VARCHAR(20),
ADD COLUMN IF NOT EXISTS tiempo_cancelacion INTEGER DEFAULT 120; -- minutos

-- Agregar columnas de redes sociales
ALTER TABLE barbershops 
ADD COLUMN IF NOT EXISTS instagram VARCHAR(255),
ADD COLUMN IF NOT EXISTS facebook VARCHAR(255);
    
-- Verificar que las columnas se agregaron correctamente
SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    column_default
FROM information_schema.columns 
WHERE table_name = 'barbershops' 
ORDER BY column_name;

-- Mostrar la estructura actualizada de la tabla
\d barbershops;
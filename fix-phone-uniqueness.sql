-- ===================================================================
-- SCRIPT PARA RESOLVER PROBLEMA DE TELÉFONOS ÚNICOS
-- ===================================================================
-- Este script elimina el índice único de teléfonos y modifica la tabla
-- para permitir teléfonos opcionales y duplicados

-- 1. Eliminar los índices únicos actuales
DROP INDEX IF EXISTS idx_clients_phone_barbershop;
DROP INDEX IF EXISTS idx_clients_phone_unique;

-- 2. Modificar la tabla para hacer el teléfono opcional (permitir NULL)
ALTER TABLE clients ALTER COLUMN telefono DROP NOT NULL;

-- 3. Crear un nuevo índice no único para mantener el rendimiento en búsquedas
CREATE INDEX idx_clients_phone_search ON clients(telefono) WHERE telefono IS NOT NULL;

-- 4. Verificar la estructura actualizada
SELECT 
    column_name, 
    is_nullable, 
    data_type 
FROM information_schema.columns 
WHERE table_name = 'clients' 
AND column_name = 'telefono';

-- 5. Mostrar índices actuales en la tabla clients
SELECT 
    indexname, 
    indexdef 
FROM pg_indexes 
WHERE tablename = 'clients' 
AND (indexname LIKE '%phone%' OR indexname LIKE '%telefono%');

-- 6. Verificar que no existan restricciones de unicidad
SELECT 
    conname as constraint_name,
    contype as constraint_type,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint 
WHERE conrelid = 'clients'::regclass 
AND contype = 'u';
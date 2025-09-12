-- ============================================
-- VERIFICAR RESET DE BASE DE DATOS
-- Sistema de Barberías
-- ============================================

-- Verificar que no existan tablas del sistema anterior
SELECT 
    'TABLAS EXISTENTES' as check_type,
    table_name,
    table_type
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- Verificar que no existan tipos ENUM
SELECT 
    'TIPOS ENUM EXISTENTES' as check_type,
    typname as type_name
FROM pg_type 
WHERE typtype = 'e' 
AND typname IN ('appointment_status', 'user_role', 'day_of_week');

-- Verificar que no existan funciones personalizadas
SELECT 
    'FUNCIONES EXISTENTES' as check_type,
    proname as function_name,
    pg_get_function_identity_arguments(p.oid) as arguments
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public'
AND proname IN (
    'handle_new_user',
    'update_updated_at_column',
    'check_appointment_conflict',
    'calculate_appointment_end_time',
    'get_available_time_slots',
    'update_appointment_status'
);

-- Verificar extensiones instaladas
SELECT 
    'EXTENSIONES INSTALADAS' as check_type,
    extname as extension_name,
    extversion as version
FROM pg_extension
WHERE extname NOT IN ('plpgsql');

-- Contar registros de autenticación (si tienes acceso)
-- SELECT 
--     'USUARIOS AUTH' as check_type,
--     count(*) as total_users
-- FROM auth.users;

-- Mensaje final
SELECT 
    CASE 
        WHEN (SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public') = 0
        THEN 'SUCCESS: Base de datos completamente limpia - Lista para nueva migración'
        ELSE 'WARNING: Aún existen ' || (SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public') || ' tablas'
    END as reset_status;
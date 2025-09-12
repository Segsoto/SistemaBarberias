-- ===================================================================
-- LIMPIAR BASE DE DATOS COMPLETAMENTE Y EMPEZAR DE CERO
-- ===================================================================
-- Ejecuta SOLO este script primero para limpiar todo

-- Eliminar todas las tablas que pudieran existir
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS barbers CASCADE;
DROP TABLE IF EXISTS barbershops CASCADE;
DROP TABLE IF EXISTS reports CASCADE;

-- Eliminar tipos ENUM
DROP TYPE IF EXISTS appointment_status CASCADE;
DROP TYPE IF EXISTS service_type CASCADE;

-- Eliminar funciones
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;

-- Mensaje de confirmación
SELECT 'Base de datos completamente limpia. Ahora ejecuta el script principal.' as resultado;
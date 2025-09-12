-- ============================================
-- SCRIPT DE RESPALDO Y MIGRACIÓN SEGURA
-- Sistema de Barberías
-- ============================================

-- PASO 1: Crear respaldo de datos importantes (opcional)
-- Ejecuta esto ANTES del reset si quieres guardar algunos datos

-- Crear tabla temporal para respaldo de usuarios importantes
CREATE TABLE IF NOT EXISTS backup_users AS 
SELECT * FROM profiles WHERE role = 'admin' OR role = 'owner';

-- Crear tabla temporal para respaldo de barberías
CREATE TABLE IF NOT EXISTS backup_barbershops AS 
SELECT * FROM barbershops;

-- Crear tabla temporal para respaldo de servicios
CREATE TABLE IF NOT EXISTS backup_services AS 
SELECT * FROM services;

-- PASO 2: Después del reset, puedes restaurar datos críticos
-- (Ejecuta esto después de correr el nuevo script de migración)

/*
-- Restaurar barberías
INSERT INTO barbershops (name, address, phone, email, created_at)
SELECT name, address, phone, email, created_at FROM backup_barbershops
ON CONFLICT (email) DO NOTHING;

-- Restaurar servicios básicos
INSERT INTO services (name, description, price, duration_minutes, barbershop_id, created_at)
SELECT s.name, s.description, s.price, s.duration_minutes, b.id, s.created_at 
FROM backup_services s
JOIN barbershops b ON b.name = (SELECT name FROM backup_barbershops WHERE id = s.barbershop_id)
ON CONFLICT DO NOTHING;

-- Limpiar tablas de respaldo
DROP TABLE IF EXISTS backup_users;
DROP TABLE IF EXISTS backup_barbershops;
DROP TABLE IF EXISTS backup_services;
*/

SELECT 'Respaldo completado. Ejecuta reset-database.sql y luego tu nuevo script de migración.' as message;
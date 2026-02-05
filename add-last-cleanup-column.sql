-- Agregar columna para registrar la última fecha en que se mostró el prompt de limpieza
ALTER TABLE barbershops
ADD COLUMN IF NOT EXISTS last_cleanup_prompt_date DATE;

-- Verificar columna
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'barbershops' AND column_name = 'last_cleanup_prompt_date';

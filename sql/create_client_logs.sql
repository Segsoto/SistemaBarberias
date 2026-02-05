-- Tabla para almacenar logs de clientes (errores de login, info de dispositivo)
CREATE TABLE IF NOT EXISTS client_logs (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at timestamptz DEFAULT now(),
  origin text,
  user_agent text,
  error_text text,
  details jsonb
);

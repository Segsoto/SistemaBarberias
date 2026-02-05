export const logClientError = async (payload: any) => {
  try {
    // Enviar al endpoint serverless; no incluir secretos ni contraseñas en el payload
    await fetch('/api/client-logs', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        ...payload,
        userAgent: typeof navigator !== 'undefined' ? navigator.userAgent : null,
        origin: typeof location !== 'undefined' ? location.origin : null,
        ts: new Date().toISOString(),
      }),
    })
  } catch (e) {
    // No interrumpir la experiencia del usuario si falla el envío de logs
    // eslint-disable-next-line no-console
    console.warn('logClientError failed', e)
  }
}

export default logClientError

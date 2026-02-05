import { NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

export async function POST(req: Request) {
  try {
    const body = await req.json()

    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
    const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY
    if (!supabaseUrl || !serviceKey) {
      return NextResponse.json({ error: 'Missing Supabase env vars' }, { status: 500 })
    }

    const supabase = createClient(supabaseUrl, serviceKey)

    await supabase.from('client_logs').insert({
      origin: body.origin ?? null,
      user_agent: body.userAgent ?? null,
      error_text: body.message ?? null,
      details: body ?? {},
    })

    return NextResponse.json({ ok: true })
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('client-logs error:', err)
    return NextResponse.json({ error: String(err) }, { status: 500 })
  }
}

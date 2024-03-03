import { NextResponse, NextRequest } from 'next/server'
import { login } from './app/lib/auth'

export default async function middleware(request: NextRequest) {
  // 準備
  const { pathname } = request.nextUrl

  // Login時の処理
  if (pathname === '/login') {
    // 認可コードの取得
    const code = request.nextUrl.searchParams
      .toString()
      .split('&')[0]
      .split('=')[1]

    // ログイン処理
    const data = await login(code)

    // Cookieの設定
    const response = NextResponse.redirect(new URL('/', request.url))
    response.cookies.set('userId', data.user_id, {
      maxAge: 60 * 60 * 24 * 7, // One week
    })
    response.cookies.set('userAccessDigest', data.user_access_digest, {
      maxAge: 60 * 60 * 24 * 7, // One week
    })

    // リダイレクト
    return response
  }
  // マッチしなかったら表示
  return NextResponse.next()
}

export const config = {
  /*
   * Match all request paths except for the ones starting with:
   * - api (API routes)
   * - _next/static (static files)
   * - _next/image
   * - assets
   * - favicon.ico (favicon file)
   * - sw.js (Service Worker file)
   */
  matcher: ['/((?!api|_next/static|_next/image|assets|favicon.ico|sw.js).*)'],
}

'use server'

export async function login(code) {
  try {
    const response = await fetch(
      `${process.env.API_BASE_URL}/authentications`,
      {
        method: 'POST',
        headers: {
          'Content-type': 'application/json',
        },
        body: JSON.stringify({
          code: code,
        }),
      },
    )
    const data = await response.json()
    console.log(data)
    console.log('ログインに成功しました')
    return data
  } catch (error) {
    console.log(error)
    console.log('ログインに失敗しました')
  }
}

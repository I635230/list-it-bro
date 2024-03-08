'use server'

import { cookies } from 'next/headers'

// 検索
export async function fetchResults(query) {
  try {
    // 準備
    const type = query['type'] || 'playlist'
    const term = query['term'] || 'all'
    const order = query['order'] || 'fav_desc'
    const target = query['target'] || 'title'
    const page = query['page'] || '1'
    let keywords = query['field'] || ''

    if (keywords == null) {
      keywords = field
    }

    let url = process.env.API_BASE_URL

    // type
    if (type == 'playlist') {
      url += '/playlists'
    } else if (type == 'clip') {
      url += '/clips'
    }

    // term
    url += `?term=${term}`

    // order
    url += `&order=${order}`

    // target
    url += `&${target}=${keywords}`

    // page
    url += `&page=${page}`

    // TODO
    console.log(url)

    const response = await fetch(`${url}`)

    if (!response.ok) {
      throw new Error('検索結果の取得に失敗しました')
    }

    const data = await response.json()

    // 出力
    if (data.meta.elementCount == 0) return null
    else return data
  } catch (error) {
    throw new Error(error)
  }
}

// clipを取得するメソッド
export async function fetchClip() {}

// playlistを取得するメソッド
export async function fetchPlaylist() {}

// current_userが作成したプレイリスト一覧を取得するメソッド
export async function fetchCreatedPlaylists() {}

// current_userがお気に入りしたプレイリスト一覧を取得するメソッド
export async function fetchFavoritedPlaylists() {}

// current_userがフォローしている配信者一覧を取得するメソッド
export async function fetchFollowingBroadcasters() {}

// broadcasterのすべての名前を取得
export async function fetchBroadcastersName() {
  try {
    const response = await fetch(`${process.env.API_BASE_URL}/broadcasters`)
    const data = await response.json()
    return data
  } catch (error) {
    console.log('broadcasterの名前の取得に失敗しました')
  }
}

// userのすべての名前を取得
export async function fetchUsersName() {
  try {
    const response = await fetch(`${process.env.API_BASE_URL}/users`)
    const data = await response.json()
    return data
  } catch (error) {
    console.log('userの名前の取得に失敗しました')
  }
}

// gameのすべての名前を取得
export async function fetchGamesName() {
  try {
    const response = await fetch(`${process.env.API_BASE_URL}/games`)
    const data = await response.json()
    return data
  } catch (error) {
    console.log('gameの名前の取得に失敗しました')
  }
}

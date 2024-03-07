'use server'

import { cookies } from 'next/headers'

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

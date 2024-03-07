'use server'

import { cookies } from 'next/headers'

// 検索
export async function searchAction(query) {
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

// clipIdからBroadcasterのclipsをDBに追加
export async function addClipInfo(state, formData) {
  async function clipToBroadcaster(clipId) {
    try {
      // clipIdをbroadcasterIdに変換
      const response = await fetch(
        `${process.env.API_BASE_URL}/get_clip_broadcaster`,
        {
          method: 'POST',
          headers: {
            'Content-type': 'application/json',
          },
          body: JSON.stringify({
            clip_id: clipId,
          }),
        },
      )

      // broadcasterId取得に失敗したとき
      if (!response.ok) {
        throw new Error('broadcasterIdの取得に失敗しました')
      }

      // output
      const broadcasterId = await response.json()
      console.log('broadcasterIdの取得に成功しました')
      return broadcasterId
    } catch (error) {
      console.log('broadcasterIdの取得に失敗しました')
      return false
    }
  }

  async function createBroadcaster(broadcasterId) {
    try {
      // broadcasterを作成
      const response = await fetch(`${process.env.API_BASE_URL}/broadcasters`, {
        method: 'POST',
        headers: {
          'Content-type': 'application/json',
        },
        body: JSON.stringify({
          broadcaster_id: broadcasterId,
        }),
      })

      // broadcaster作成に失敗したとき
      if (!response.ok) {
        throw new Error('clipsの追加に失敗しました')
      }

      // output
      console.log('broadcasterの作成に成功しました')
      return true
    } catch (error) {
      console.log('broadcasterの作成に失敗しました')
      return false
    }
  }

  async function addClips(broadcasterId) {
    try {
      // clipsデータを取得
      const response = await fetch(`${process.env.API_BASE_URL}/get_clips`, {
        method: 'POST',
        headers: {
          'Content-type': 'application/json',
        },
        body: JSON.stringify({
          broadcaster_id: broadcasterId,
          all: true,
        }),
      })

      // clipsデータ取得に失敗したとき
      if (!response.ok) {
        throw new Error('clipsの追加に失敗しました')
      }

      // output
      console.log('clipsの追加に成功しました')
      return true
    } catch (error) {
      console.log('clipsの追加に失敗しました')
      return false
    }
  }

  // formDataをClipIdに変換
  let clipId
  try {
    clipId = formData.get('clipId')
  } catch (error) {
    throw new Error('clipIdの取得に失敗しました')
  }

  // ClipIdをBroadcasterIdに変換
  const broadcasterId = await clipToBroadcaster(clipId)
  if (!broadcasterId) {
    throw new Error('broadcasterIdの取得に失敗しました')
  }

  // BroadcasterIdからBroadcasterを生成
  let isValid = await createBroadcaster(broadcasterId)
  if (!isValid) {
    throw new Error('broadcasterの生成に失敗しました')
  }

  // BroadcasterIdからclipsデータを取得
  isValid = await addClips(broadcasterId)
  if (!isValid) {
    throw new Error('clipsデータの取得に失敗しました')
  }
}

// プレイリスト作成
export async function createPlaylist({ listName }) {
  try {
    const response = await fetch(`${process.env.API_BASE_URL}/playlists`, {
      method: 'POST',
      headers: {
        userId: cookies().get('userId')?.value,
        userAccessDigest: cookies().get('userAccessDigest')?.value,
        'Content-type': 'application/json',
      },
      body: JSON.stringify({
        title: 'playlist-n',
      }),
    })
    console.log('playlistの作成に成功しました')
  } catch (error) {
    console.log('playlistの作成に失敗しました')
  }
}

// プレイリスト削除
export async function deletePlaylist({ listId }) {}

// プレイリスト名編集
export async function updatePlaylistName({ listName }) {}

// クリップをプレイリストに追加
export async function addClipToPlaylist({ clipId, listId }) {}

// クリップをプレイリストから削除
export async function deleteClipFromPlaylist({ listId }) {}

// プレイリストを作成してクリップを追加
export async function createPlaylistAndAddClip({ listName }) {
  createPlaylist()
  addClipToPlaylist()
}

// お気に入り
export async function favorite({ listId }) {}

// お気に入り解除
export async function unfavorite({ listId }) {}

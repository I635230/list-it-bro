'use server'

import { cookies } from 'next/headers'

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

export async function addClipInfo(state, formData) {
  // formDataをClipIdに変換
  let clipId
  try {
    clipId = formData.get('clipId')
  } catch (error) {
    console.log('formDataの値が不正です')
    return
  }

  // ClipIdをBroadcasterIdに変換
  const broadcasterId = await clipToBroadcaster(clipId)
  if (!broadcasterId) {
    return
  }

  // BroadcasterIdからBroadcasterを生成
  let isValid = await createBroadcaster(broadcasterId)
  if (!isValid) {
    return
  }

  // BroadcasterIdからclipsデータを取得
  isValid = await addClips(broadcasterId)
  if (!isValid) {
    return
  }
}

export async function createPlaylist() {
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

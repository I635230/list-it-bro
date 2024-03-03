'use client'

import { createPlaylist } from '@/app/lib/action'

export default function Page() {
  async function createAction() {
    await createPlaylist()
  }

  return (
    <>
      <button onClick={() => createAction()}>プレイリストを作成</button>
    </>
  )
}

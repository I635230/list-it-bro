'use client'

import { useFormState } from 'react-dom'
import { addClipInfo } from '@/app/lib/action'

export default function Page() {
  const [error, formAction] = useFormState(addClipInfo, '')

  return (
    <>
      <form action={formAction}>
        <input
          type="text"
          className="form-control"
          name="clipId"
          placeholder="Enter ClipId"
        />
        <button type="submit">クリップIDを送信</button>
      </form>
    </>
  )
}

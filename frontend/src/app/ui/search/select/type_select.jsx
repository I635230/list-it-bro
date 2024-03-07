'use client'

import Select from '@/app/ui/search/select/select'

export default function TypeSelect() {
  const options = [
    {
      value: 'playlist',
      label: 'プレイリスト',
    },
    {
      value: 'clip',
      label: 'クリップ',
    },
  ]

  return (
    <>
      <Select name={'type'} label="種別" options={options} queryLabel="type" />
    </>
  )
}

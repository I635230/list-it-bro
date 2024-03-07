'use client'

import Select from '@/app/ui/search/select/select'

export default function TargetSelect({ type }) {
  let options
  if (type == 'playlist') {
    options = [
      {
        value: 'title',
        label: 'タイトル',
      },
      {
        value: 'creator',
        label: '作成者名',
      },
    ]
  } else if (type == 'clip') {
    options = [
      {
        value: 'title',
        label: 'タイトル',
      },
      {
        value: 'broadcaster',
        label: '配信者名',
      },
      {
        value: 'game',
        label: 'ゲームタイトル',
      },
    ]
  }

  return (
    <Select
      name={'target'}
      label="検索対象"
      options={options}
      queryLabel="target"
    />
  )
}

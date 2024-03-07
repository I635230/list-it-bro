'use client'

import Select from '@/app/ui/search/select/select'

export default function OrderSelect({ type }) {
  let options
  if (type == 'playlist') {
    options = [
      {
        value: 'fav_desc',
        label: 'お気に入り数の多い順',
      },
      {
        value: 'date_desc',
        label: '新しい順',
      },
      {
        value: 'date_asc',
        label: '古い順',
      },
    ]
  } else if (type == 'clip') {
    options = [
      {
        value: 'view_desc',
        label: '視聴数の多い順',
      },
      {
        value: 'date_desc',
        label: '新しい順',
      },
      {
        value: 'date_asc',
        label: '古い順',
      },
    ]
  }

  return (
    <Select
      name={'order'}
      label={'並び順'}
      options={options}
      queryLabel="order"
    />
  )
}

'use client'

import Select from '@/app/ui/search/select/select'

export default function TermSelect() {
  const options = [
    {
      value: 'all',
      label: '全期間',
    },
    {
      value: 'week',
      label: '1週間',
    },
    {
      value: 'month',
      label: '1カ月',
    },
    {
      value: 'year',
      label: '1年',
    },
  ]

  return (
    <Select name={'term'} label={'期間'} options={options} queryLabel="term" />
  )
}

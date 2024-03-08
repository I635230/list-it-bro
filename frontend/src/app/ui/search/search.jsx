'use client'

import { useDebouncedCallback } from 'use-debounce'
import { useSearchParams, usePathname, useRouter } from 'next/navigation'
import TypeSelect from '@/app/ui/search/select/type_select'
import TermSelect from '@/app/ui/search/select/term_select'
import OrderSelect from '@/app/ui/search/select/order_select'
import TargetSelect from '@/app/ui/search/select/target_select'

export default function Search({ broadcastersName, usersName, gamesName }) {
  // router
  const { replace } = useRouter()

  // page
  const searchParams = useSearchParams()
  const currentPage = searchParams.get('page') || 1

  // path
  const pathname = usePathname()

  const changeQuery = useDebouncedCallback((newValue) => {
    const params = new URLSearchParams(searchParams)
    if (newValue) {
      params.set('field', newValue)
    } else {
      params.delete('field')
    }
    replace(`/search?${params.toString()}`)
  }, 300)

  return (
    <>
      <TypeSelect />
      <TermSelect />
      <OrderSelect type={searchParams.get('type') || 'playlist'} />
      <TargetSelect type={searchParams.get('type') || 'playlist'} />
      <input
        onChange={(e) => {
          changeQuery(e.target.value)
        }}
        defaultValue={searchParams.get('field')?.toString() || ''}
      />
    </>
  )
}

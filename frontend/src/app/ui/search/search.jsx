'use client'

// import { useFormState } from 'react-dom'
import { useSearchParams, usePathname } from 'next/navigation'
// import { searchAction } from '@/app/lib/action'
import TypeSelect from '@/app/ui/search/select/type_select'
import TermSelect from '@/app/ui/search/select/term_select'
import OrderSelect from '@/app/ui/search/select/order_select'
import TargetSelect from '@/app/ui/search/select/target_select'
// import ClipsResult from '@/app/ui/search/result/clips_result'
// import PlaylistsResult from '@/app/ui/search/result/playlists_result'

export default function Search({ broadcastersName, usersName, gamesName }) {
  // page
  const searchParams = useSearchParams()
  const currentPage = searchParams.get('page') || 1

  // path
  const pathname = usePathname()

  // select

  // results
  // const [results, formAction] = useFormState(searchAction, '')

  return (
    <>
      <form>
        <TypeSelect />
        <TermSelect />
        <OrderSelect type={searchParams.get('type') || 'playlist'} />
        <TargetSelect type={searchParams.get('type') || 'playlist'} />
        <input
          type="text"
          name="search_field"
          value={searchParams.get('field')}
        />
        <button type="submit">検索</button>
      </form>
    </>
  )
}

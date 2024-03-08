'use server'

import Search from '@/app/ui/search/search'
import Result from '@/app/ui/search/result'
import {
  fetchBroadcastersName,
  fetchUsersName,
  fetchGamesName,
  fetchResults,
} from '@/app/lib/data'

export default async function DataFetcher({ searchParams }) {
  const broadcastersName = await fetchBroadcastersName()
  const usersName = await fetchUsersName()
  const gamesName = await fetchGamesName()
  return (
    <>
      <Search
        broadcastersName={broadcastersName}
        usersName={usersName}
        gamesName={gamesName}
      />
      <Result fetchResults={fetchResults} query={searchParams} />
    </>
  )
}

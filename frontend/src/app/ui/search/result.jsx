import ClipsResult from '@/app/ui/search/result/clips_result'
import PlaylistsResult from '@/app/ui/search/result/playlists_result'

export default async function Result({ searchAction, query }) {
  const results = await searchAction(query)

  return (
    <>
      {results?.clips && <ClipsResult results={results} />}
      {results?.playlists && <PlaylistsResult results={results} />}
    </>
  )
}

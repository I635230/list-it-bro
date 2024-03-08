import ClipsResult from '@/app/ui/search/result/clips_result'
import PlaylistsResult from '@/app/ui/search/result/playlists_result'
import Pagination from '@/app/ui/search/pagination'

export default async function Result({ fetchResults, query }) {
  const results = await fetchResults(query)

  return (
    <>
      {results?.clips && <ClipsResult results={results} />}
      {results?.playlists && <PlaylistsResult results={results} />}
      {results && (
        <Pagination
          currentPage={query?.['page'] || '1'}
          path={'/search'}
          limit={20}
          elementsCount={results.meta.elementsCount}
        />
      )}
    </>
  )
}

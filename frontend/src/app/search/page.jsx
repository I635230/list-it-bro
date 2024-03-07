import DataFetcher from '@/app/ui/search/data_fetcher'
import { Suspense } from 'react'

export default function Page({ searchParams }) {
  console.log(searchParams)

  return (
    <>
      <Suspense>
        <DataFetcher searchParams={searchParams} />
      </Suspense>
    </>
  )
}

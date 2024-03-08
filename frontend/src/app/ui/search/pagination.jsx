'use client'

import { useSearchParams, useRouter } from 'next/navigation'

export default function Pagination({
  currentPage,
  path,
  limit,
  elementsCount,
}) {
  //
  const searchParams = useSearchParams()
  const { replace } = useRouter()

  // page設定
  currentPage = Number(currentPage)
  const totalPages = Math.ceil(elementsCount / limit)
  let startPage = Math.max(1, currentPage - 2)
  let endPage = Math.min(totalPages, currentPage + 2)

  if (currentPage <= 3) {
    endPage = Math.min(5, totalPages)
  } else if (currentPage >= totalPages - 2) {
    startPage = totalPages - 4
  }

  const pageNumbers = []
  for (let i = startPage; i <= endPage; i++) {
    pageNumbers.push(i)
  }

  function handleClick(page) {
    const params = new URLSearchParams(searchParams)
    if (page) {
      params.set('page', page)
    } else {
      params.delete('page')
    }
    replace(`/search?${params.toString()}`)
  }

  return (
    <>
      {pageNumbers.map((page) => (
        <button onClick={() => handleClick(page)}>{page}</button>
      ))}
    </>
  )
}

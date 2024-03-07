import { useRouter, useSearchParams } from 'next/navigation'

export default function Select({ label, options, name, queryLabel }) {
  const searchParams = useSearchParams()
  const { replace } = useRouter()

  function changeQuery(newValue) {
    const params = new URLSearchParams(searchParams)
    params.set('page', '1')
    if (newValue) {
      params.set(queryLabel, newValue)
    } else {
      params.delete(queryLabel)
    }
    replace(`/search?${params.toString()}`)
  }

  return (
    <div>
      <label>
        {label}
        <select
          name={name}
          value={searchParams.get(queryLabel?.toString())}
          onChange={(e) => {
            changeQuery(e.target.value)
          }}
        >
          {options?.map((option, index) => (
            <option key={index} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      </label>
    </div>
  )
}

import { useRouter, useSearchParams } from 'next/navigation'

export default function Select({ label, options, name, queryLabel }) {
  const searchParams = useSearchParams()
  const { replace } = useRouter()

  function changeQuery(newValue) {
    const params = new URLSearchParams(searchParams)
    if (newValue) {
      params.set(queryLabel, newValue)
    } else {
      params.delete(queryLabel)
    }

    // typeの変更時に、可変プルダウンの値を初期化
    if (queryLabel == 'type') {
      const typeValue = params.get(queryLabel)

      let orderValue
      let targetValue

      // type=playlistのとき
      if (typeValue == 'playlist') {
        orderValue = 'fav_desc'
        targetValue = 'title'
      }

      // type=clipのとき
      if (typeValue == 'clip') {
        orderValue = 'view_desc'
        targetValue = 'title'
      }

      // eachValue
      for (let [eachLabel, eachValue] of [
        ['order', orderValue],
        ['target', targetValue],
      ]) {
        if (eachValue) {
          params.set(eachLabel, eachValue)
        } else {
          params.delete(eachLabel)
        }
      }
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

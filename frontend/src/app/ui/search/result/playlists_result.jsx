export default function PlaylistsResult({ results }) {
  return (
    <div>
      {results.playlists.map((result, index) => (
        <div key={index}>
          <img
            src={result.first_clip_thumbnail_url}
            alt={result.first_clip_thumbnail_url}
          />
          <div>{result.title}</div>
          <div>{result.slug}</div>
          <div>作成者: {result.creator_name}</div>
          <div>お気に入り数: {result.favorites_count}</div>
          <div>クリップ数: {result.clips_count}</div>
          <div>作成日: {result.created_at.slice(0, 10)}</div>
        </div>
      ))}
    </div>
  )
}

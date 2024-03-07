export default function ClipsResult({ results }) {
  return (
    <div>
      {results.clips.map((result, index) => (
        <div key={index}>
          <img src={result.thumbnail_url} alt={result.thumbnail_url} />
          <div>{result.title}</div>
          <div>{result.slug}</div>
          <div> 配信者: {result.broadcaster_name}</div>
          <div> 作成者: {result.creator_name}</div>
          <div>ゲームタイトル: {result.game_name}</div>
          <div>時間: {result.duration}</div>
          <div>視聴数: {result.view_count}</div>
          <div>作成日: {result.clip_created_at.slice(0, 10)}</div>
        </div>
      ))}
    </div>
  )
}

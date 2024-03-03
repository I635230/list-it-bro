export default function Header() {
  return (
    <div>
      <a
        href={`https://id.twitch.tv/oauth2/authorize?response_type=code&client_id=${process.env.CLIENT_ID}&redirect_uri=http://localhost:3000/login&scope=user:read:follows`}
      >
        ログイン
      </a>
    </div>
  )
}

# 設計
## 業務フロー
### プレイリスト作成者
![プレイリスト作成者](https://www.plantuml.com/plantuml/png/SoWkIImgAStDuKfCBialKdZSFFrnyvh7JKiUDwzwtBJpSNF7axrpddLCUD7Ggf1Oh91go5K0L9-Pd5cGc5U2HVNBQPjUB5l-k7dMu-OzZvjsWFMO4D3pVDt2vnFQ7ZTj1tFR7ZSl06ipuaf9B4bCIYnEnQB7nGcinfWhrL11rmveXu8LDfCNxNgngfSBA0jIOuXLpOk5AvulsGKpnmYk1ZCC7ZVlVhvznSlPRLofHc35njWLxv_xTEqCBg0iReSzNTBvRFQMf_szpsOi8Cfv3gbvAS1O0W00)

### プレイリスト閲覧者
![プレイリスト閲覧者](https://www.plantuml.com/plantuml/png/SoWkIImgAStDuKfCBialKdZSFFrnyvh7JKiUDwzwtBJpSNF7oscRNYnR_gAXLI6nM27LaAi0g3upERCWCQy4f-h7pRCUD-zvtBG3hCU4W9xdwnO-dz3sk6axcDlsk7a1M9iHLqfYIM9IOd4g5ZqkJc0rnbofXWgwTa0x5AomcRnerujLlLn0MP0QGwngNYnSyNp9BYw7rBmKO3000000)

## 画面遷移図
![画面遷移図](./img/画面遷移図.png)

## ワイヤフレーム
### ヘッダー
![header](./img/header.png)

**機能**
* サービスロゴをクリックすると、*TOP*へ遷移
* 虫眼鏡をクリックすると、入力された情報を検索ワードとし*SearchResult*に遷移
* ログインログアウト
* 自分の*Library*に遷移

**データ**
* ログイン中のユーザー情報

### サイドバー
<img src="./img/sidebar.png" width="200px">

**機能**
* 作成したプレイリスト一覧ボタンを押すと、プレイリスト一覧が表示される
* お気に入りプレイリスト一覧ボタンを押すと、お気に入りプレイリスト一覧が表示される
* フォロー配信者一覧ボタンを押すと、フォロー配信者一覧が表示される

[作成したプレイリスト一覧]
* 作成したプレイリストの一覧を表示
* *Playlist*へ遷移できる
* プレイリストの並び順は、作成日の新しい順

[お気に入りプレイリスト一覧]
* お気に入りプレイリストの一覧を表示
* *Playlist*へ遷移できる
* プレイリストの並び順は、作成日の新しい順

[フォローした配信者一覧]
* 自分がフォローしている配信者一覧が表示される
* 配信者名をクリックすると、*Search*のその配信者でソートした結果に遷移する

**データ**
* 自分が作成したプレイリストの情報
* 自分がお気に入りしたプレイリストの情報
* 自分がフォローしている配信者の情報

### トップ(/)
![Top](./img/top.png)

**機能**
* TOP画面を表示
* プレイリストをクリックすると*Playlist*へ遷移
* クリップをクリックすると*Watch*へ遷移
* クリップのDaily, Weekly, Monthlyをクリックすると、指定したランキングを表示

**データ**
* 1週間以内に作成されたプレイリストの中で、お気に入り数が多いものの情報
* クリップ視聴数のDaily, Weekly, Monthlyランキング情報

### ライブラリ(/users)
![Library](./img/library.png)

**機能**
* 共通
  * プレイリストの一覧を表示
  * ユーザー名の表示
  * プレイリストをXに共有
  * *Playlist*へ遷移できる
  * プレイリストの並び順は、作成日の新しい順
* 自分のライブラリのとき
  * タブでお気に入りと作成したプレイリストを切り替え
  * プレイリストの公開非公開
  * プレイリスト削除
  * プレイリストの名前の変更
* 他人のライブラリのとき
  * プレイリストをお気に入りに追加・解除

**データ**
* 自分が作成したプレイリストの情報
* 自分がお気に入りしたプレイリストの情報

### プレイリスト(/playlists)
![Playlist](./img/playlist.png)

**機能**
* クリップ一覧を表示
* Clip Playに遷移するときにPlaylistのクリップ一覧データを渡す
* プレイリスト名の編集
* プレイリストの削除
* クリップの削除
* クリップの並べ替え(ドラッグアンドドロップ)
* プレイリストをXに共有
* 公開非公開の設定
* プレイリストのデータを表示

**データ**
* プレイリストの情報
* 属する先頭クリップのサムネイル画像
* 属する先頭クリップのID

### クリップ(/watch)
![Watch](./img/watch.png)

**機能**
* 共通
  * 指定したクリップを表示
  * →をクリックすると、次の(前の)クリップを表示
  * 「Xに共有」をクリックすると、Xの画面を表示
  * 画面右のクリップをクリックすると、指定したクリップを表示
* 自分のプレイリスト
  * 画面右にクリップの属するプレイリストを表示
  * 「プレイリストから削除」をクリックすると、プレイリストからクリップを削除する。
  *  「ハートマーク」をクリックすると、お気に入りに追加
* 他人のプレイリスト
  *  画面右にクリップの属するプレイリストを表示
  *  「プレイリストに追加」をクリックすると、プレイリストを指定してクリップを追加
  *  「プレイリストを作成して追加」をクリックしたとき、プレイリスト名を指定して作成し、そのプレイリストにクリップを追加
  *  「ハートマーク」をクリックすると、お気に入りに追加
*  プレイリスト情報無し
   *  画面右にWeeklyランキングを表示
   *  「プレイリストに追加」をクリックすると、プレイリストを指定してクリップを追加
   *  「プレイリストを作成して追加」をクリックしたとき、プレイリスト名を指定して作成し、そのプレイリストにクリップを追加

**データ**
* クリップの情報
* (あれば)属しているプレイリストのID

### 検索(/search)
![Search](./img/search.png)

**機能**
* プレイリストとクリップを選択するボタンがある
  * デフォルトはプレイリストのみの表示で、ボタンを押すことでプレイリストのみの表示とクリップのみの表示を切り替え
* 期間の指定(1週間, 1カ月, 1年間, 全期間)をするプルダウンがある
  * デフォルトは1週間で、選択することで表示するデータの期間を切り替え
* 並び替えの指定(お気に入り数が多い順, 視聴数が多い順, 新しい順, 古い順)をするプルダウンがある
  * デフォルトはプレイリストならお気に入り数が多い順、クリップなら視聴数が多い順で、選択することで表示するデータの順番を切り替え
  * お気に入り数が多い順はプレイリスト、視聴数が多い順はクリップを表示しているときしか選択できない
* プレイリスト/クリップの一覧を表示
* プレイリストをクリックすると*Playlist*に遷移
* クリップをクリックすると*Watch*に遷移
* ページネーション

**データ**
* クリップの情報
* (あれば)属しているプレイリストのID

## ER図
![ER図](https://www.plantuml.com/plantuml/png/jLF1QXin4BtlLmov50e9JTCaK488BQI7N7BfMOnNuzqXMcaPZUoQnFzUsInPhsKRIeblyvxqtfjdxKDK54sTgpv1ovP0MuBO1wssKyrIEweoYOl05de9CqTTX2Lh2-WRHnPg2Si8SoAjuWlx7WKxSEn9Lpr146r3LP5NrXMS_OuaPu0HwCibl5O0dxFiTvXnmrxX-IaZv-SRs8MCP2Qgi6ysYENOErmPZnrDY9ngpeuCTzYGIU8cRCgE1kkQOZGQNcWgAZGNYkq-inuJ_v20jiQexy6_VcZm8i2lV6rmlZhfNEZFmX-3eaULVphk1-LlXvJXxguXJu9Azlx-tIUwr4nzneeodYib8LzJXCUdFRhie1P23M9sd7VXudop1KeJXxv9s4mFAwlRiyihcwquMOEQEOjAoXrjpxUfctbaLxmYcmILWy_Wt0NSPbmmBKqTajT9z22MP4JMrLZuiyELuwX3wTV_KtgvMue7-b-NxZj_-qsHu8XzFzmjz8TEJ_a-uY88AmsUjuUs_aVRK-lct-ORVNkxk0YlcwUTnwlfU7DqlDvSlXtdo-cOwUg1l4sT-mi0)

## システム構成図
デプロイ先選定中なので、後ほど追記。

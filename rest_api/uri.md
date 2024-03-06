# movieをリソースとしたCRUD操作のURI、HTTPメソッド
| URI | HTTPメソッド | 目的|
| ---- | ---- | --- |
| /v1/movies | GET | movieリストの取得 | 
| /v1/movies/:id | GET | 特定idを持つmovieの取得 |
| /v1/movies | POST | 新規movieを作成 |
| /v1/movies/:id | UPDATE | 特定idを持つmovieの更新 |
| /v1/movies/:id | DELETE | 特定idを持つmovieの削除 |

# REST APIとは
REST という設計ルールを元に作成され、情報のやり取りにHTTPプロトコルを使用するWEB APIの1種

# 記事
https://torihazi.hateblo.jp/entry/2024/03/06/214900

# haunted-blog

フィヨルドブートキャンプ向け、Webセキュリティ学習教材です。

## プラクティスを進めるにあたって

このリポジトリのブランチを切り替えると、正解が見えてしまいます。また、他の受講生が作成した提出物も見ようと思えば見ることができます。

正解を見てしまわないように注意しながら進めていってください。 実力をつけていくためにも、自分自身の力でソースコードを完成させていきましょう。

## How to use

1. 右上の `Fork` ボタンを押してください。
2. `#{自分のアカウント名}/haunted-blog` が作成されます。
3. 作業PCの任意の作業ディレクトリにて `git clone` してください。

```
$ git clone https://github.com/自分のアカウント名/haunted-blog.git
```

4. `cd haunted-blog` でカレントディレクトリを変更してください。
5. `.ruby-version` に書かれたバージョンのRubyがインストールされていなければインストールしてください。
6. mainブランチから提出用ブランチを作成してください。（ `git checkout -b fix-vulnerability` ）
7. `bin/setup`コマンドで環境セットアップを実行してください。
8. `bin/dev` して動作確認し、スタート地点のアプリケーション仕様を把握してください。
9. http://localhost:3000/ にアクセスしてブログ一覧が表示されることを確認してください。
10. ログインする場合は以下のいずれかのログイン情報を使ってください。パスワードはいずれも "password" です。
    - alice@example.com (premiumユーザー)
    - bob@example.com （通常ユーザー)
    - carol@example.com (通常ユーザー)
11. `bundle exec rubocop` を実行して警告が出ないことを確認してください。
12. ターミナルから`bin/rails test:all`でテストを実行してください。いくつかのテストが失敗しますが、失敗するテストは以下のどちらかのテストファイルになっているはずです。
    - `test/integration/vulnerability_requests_test.rb`
    - `test/system/vulnerabilities_test.rb`
13. テストが全部パスするように、このアプリケーションの脆弱性を修正してください。要件の詳細はプラクティスページでも解説しています。
14. ソースコードが完成したら提出前にrubocopを実行し、警告の箇所を修正してください。
15. 自分が書いたコードをGitHubにpushしてください。
16. 以下の注意点に気を付けながら自分のリポジトリへのPull Requestを作成し、URLを提出してください。
    - OK `自分のアカウント名/main` ← `自分のアカウント名/fix-vulnerability`
    - NG `fjordllc/main` ← `自分のアカウント名/fix-vulnerability`
17. 合格したら上記Pull Requestをマージしてください。

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
6. mainブランチから提出用ブランチをを作成してください。（ `git checkout -b fix-vulnerability` ）
7. 以下の手順に従って環境セットアップを実行してください。
    1. `bundle install` を実行
    2. `bin/setup` を実行
    3. `yarn install` を実行
    4. `gem install foreman` を実行
    5. `bundle exec rubocop` を実行して警告が出ないことを確認
8. `bin/dev` して動作確認し、スタート地点のアプリケーション仕様を把握してください
    - このアプリはRails 7.0 + esbuildを使っているため、`rails s`ではなく`bin/dev`コマンドで起動します
9. http://localhost:3000/ にアクセスしてブログ一覧が表示されることを確認してください
10. ログインする場合は以下のいずれかのログイン情報を使ってください。パスワードはいずれも "password" です
    - alice@example.com (premiumユーザー)
    - bob@example.com （通常ユーザー)
    - carol@example.com (通常ユーザー)
11. 次に、ターミナルから`bin/rails test:all`でテストを実行してください。以下の2つのテストだけが失敗していればOKです
    - `test/integration/vulnerability_requests_test.rb`
    - `test/system/vulnerabilities_test.rb`
12. テストが全部パスするように、このアプリケーションの脆弱性を修正してください。要件の詳細はプラクティスページでも解説しています
13. ソースコードが完成したら提出前にrubocopを実行し、警告の箇所を修正してください。
14. 自分が書いたコードをGitHubにpushしてください。
15. 以下の注意点に気を付けながら自分のリポジトリへのPull Requestを作成し、URLを提出してください。
     - OK `自分のアカウント名/main` ← `自分のアカウント名/fix-vulnerability`
     - NG `fjordllc/main` ← `自分のアカウント名/fix-vulnerability`
16. 合格したら上記Pull Requestをマージしてください


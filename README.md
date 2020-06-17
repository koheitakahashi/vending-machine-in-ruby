# vending-machine-in-ruby

[TDDBC大阪3\.0/課題（自動販売機問題）](http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C)の課題をRubyで解くための解答テンプレートです。

## How to setup

このリポジトリを自分のGitHubアカウントにフォークする

<img width="158" alt="Screen Shot 2020-06-17 at 20 01 01" src="https://user-images.githubusercontent.com/1148320/84890378-4a579d80-b0d5-11ea-950c-bc16772e862b.png">

自分のローカルにフォークしたリポジトリをclone（your-nameの部分は自分のアカウントIDを入れる）

```
$ git clone git@github.com:your-name/vending-machine-in-ruby
$ cd vending-machine-in-ruby
```

Ruby 2.7.1になっていることを確認（なっていなければrbenvでRuby 2.7.1をインストール）

```
$ ruby -v
ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin19]
```

gemのインストール

```
$ bundle install
```

動作確認用のテストがパスすればセットアップ完了。

```
$ bundle exec rake
Run options: --seed 16161

# Running:

.

Finished in 0.000781s, 1280.4097 runs/s, 1280.4097 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

## How to answer

- `test/vending_machine_test.rb`や`lib/vending_machine.rb`にテストコードや実装コードを書いて、自動販売機問題を解いていく
- 必要に応じて`lib/`や`test/`にファイルを追加してもOK

### Hints

`puts`や`print`を使わず、メソッドの戻り値として要件を満たすようにすると、テストコードが書きやすくなる。以下、参考資料。

- [きみたちは今まで何のためにRailsでMVCパターンを勉強してきたのか \- Qiita](https://qiita.com/jnchito/items/e2b1c8904cd7b8e3ce50)
- 「[プロを目指す人のためのRuby入門](https://gihyo.jp/book/2017/978-4-7741-9397-7)」3.3.1項「putsメソッドをテストコードに置き換える」

## License

MIT License.

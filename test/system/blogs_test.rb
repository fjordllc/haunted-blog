# frozen_string_literal: true

require 'application_system_test_case'

class BlogsTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test 'ブログ一覧と詳細ページ' do
    sign_in_as(@alice)
    assert_current_path root_path
    assert_text 'こんにちは、アリスです'
    assert_text 'こんばんは、ボブです'
    assert_no_text '秘密のブログです'

    click_link 'こんにちは、アリスです'
    assert_text 'こんにちは。こんにちは。'

    # ログアウトしても同じように表示される
    sign_out
    assert_current_path root_path
    assert_text 'こんにちは、アリスです'
    assert_text 'こんばんは、ボブです'
    assert_no_text '秘密のブログです'

    click_link 'こんにちは、アリスです'
    assert_text 'こんにちは。こんにちは。'
  end

  test 'ブログの作成' do
    # プレミアムユーザーの場合 - アイキャッチ画像の挿入が可能
    sign_in_as(@alice)
    click_link 'New blog'
    fill_in 'タイトル', with: '今日の出来事'
    fill_in '本文', with: 'ボブと遊びました。'
    assert_field 'ランダムなアイキャッチ画像を挿入する'
    check 'ランダムなアイキャッチ画像を挿入する'
    click_button '登録する'

    assert_text 'Blog was successfully created.'
    assert_selector '.blog-post-title', text: '今日の出来事'
    assert_selector '.blog-content', text: 'ボブと遊びました。'
    assert_selector '.blog-eyecatch'

    # 通常ユーザーの場合 - アイキャッチ画像が挿入できない
    sign_out
    sign_in_as(@bob)
    click_link 'New blog'
    fill_in 'タイトル', with: '今日の出来事'
    fill_in '本文', with: 'ボブと遊びました。'
    assert_no_field 'ランダムなアイキャッチ画像を挿入する'
    click_button '登録する'

    assert_text 'Blog was successfully created.'
    assert_selector '.blog-post-title', text: '今日の出来事'
    assert_selector '.blog-content', text: 'ボブと遊びました。'
    assert_no_selector '.blog-eyecatch'
  end

  test 'ブログの編集と削除' do
    # 自分のブログは編集と削除ができる
    sign_in_as(@alice)
    visit blog_path(blogs(:alice_blog))
    click_link 'Edit this blog'
    fill_in 'タイトル', with: 'はろー、アリスです'
    click_button '更新する'

    assert_text 'Blog was successfully updated.'
    assert_selector '.blog-post-title', text: 'はろー、アリスです'

    click_link 'Edit this blog'
    accept_alert do
      click_link 'Delete'
    end
    assert_text 'Blog was successfully destroyed.'

    # 他人のブログは編集と削除ができない
    visit blog_path(blogs(:bob_blog))
    assert_selector '.blog-post-title', text: 'こんばんは、ボブです'
    assert_no_link 'Edit this blog'
  end

  test 'ブログの検索' do
    visit root_path
    assert_text 'こんにちは、アリスです'
    assert_text 'こんばんは、ボブです'

    fill_in 'Search Blogs', with: 'アリス'
    find('.btn-blog-search').click

    assert_text 'こんにちは、アリスです'
    assert_no_text 'こんばんは、ボブです'
  end

  test '本文に改行を含める' do
    sign_in_as(@alice)
    click_link 'New blog'
    fill_in 'タイトル', with: '今日の出来事'
    fill_in '本文', with: "ボブと遊びました。\n楽しかったです。\n\n本当に楽しかった。"
    click_button '登録する'
    assert_text 'Blog was successfully created.'

    # 表示上も改行される
    text = find('.blog-content').text
    assert_match(/ボブと遊びました。\n楽しかったです。\n{1,2}本当に楽しかった。/, text)
  end

  test 'いいね機能' do
    sign_in_as(@alice)

    click_link 'こんばんは、ボブです'
    assert_text 'こんばんは。こんばんは。'
    assert_text 'Liked by Alice'

    find('.btn-like').click
    assert_text 'Hit first like!'

    find('.btn-like').click
    assert_text 'Liked by Alice'
  end
end

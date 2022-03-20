require "application_system_test_case"

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

  test 'ブログのCRUD' do
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
    fill_in '本文', with: "ボブと遊びました。\n楽しかったです。"
    click_button '登録する'

    # 表示上も改行される
    assert_text 'Blog was successfully created.'
    assert_selector '.blog-content', text: "ボブと遊びました。\n楽しかったです。"
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

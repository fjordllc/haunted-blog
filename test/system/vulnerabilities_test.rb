# frozen_string_literal: true

require 'application_system_test_case'

class VulnerabilitiesTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test '検索でSQLインジェクションを起こさないこと' do
    visit root_path
    assert_text 'こんにちは、アリスです'
    assert_no_text '秘密のブログです'

    fill_in 'Search Blogs', with: "') OR secret = TRUE --"
    find('.btn-blog-search').click

    assert_text 'データがありません。'
  end

  test 'ブログ投稿でXSSを起こさないこと' do
    sign_in_as(@alice)
    click_link 'New blog'
    fill_in 'タイトル', with: '今日の出来事'
    fill_in '本文', with: '<MARQUEE>ボブと遊びました。</MARQUEE>'
    click_button '登録する'

    assert_text 'Blog was successfully created.'
    assert_selector '.blog-post-title', text: '今日の出来事'
    assert_selector '.blog-content', text: 'ボブと遊びました。'
    assert_no_selector 'marquee'
  end
end

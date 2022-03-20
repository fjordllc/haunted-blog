# frozen_string_literal: true

require 'application_system_test_case'

class MyBlogsTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
  end

  test 'ブログ一覧と詳細ページ' do
    sign_in_as(@alice)
    click_link 'My Blogs'
    assert_current_path my_blogs_path
    assert_text 'こんにちは、アリスです'
    assert_text '秘密のブログです'
    assert_no_text 'こんばんは、ボブです'

    click_link '秘密のブログです'
    assert_text 'これを見た人は死ぬ。'
  end
end

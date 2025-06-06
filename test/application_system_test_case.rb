# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |options|
    options.add_argument('--disable-gpu')
  end

  def sign_in_as(user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'p@ssw0rd'
    click_button 'Log in'
    assert_text 'ログインしました。'
  end

  def sign_out
    click_button 'Sign Out'
    assert_text 'ログアウトしました。'
  end
end

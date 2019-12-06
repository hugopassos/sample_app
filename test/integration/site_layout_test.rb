# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hugo)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', signup_path
    assert_select 'a[href=?]', users_path, count: 0
    get help_path
    assert_select 'title', full_title('Help')
    get about_path
    assert_select 'title', full_title('About')
    get contact_path
    assert_select 'title', full_title('Contact')
    get signup_path
    assert_select 'title', full_title('Sign up')
  end

  test 'should provide link for users when logged in' do
    log_in_as @user
    get root_path
    assert_select 'a[href=?]', users_path
    get users_path
    assert_select 'title', full_title('All users')
  end
end

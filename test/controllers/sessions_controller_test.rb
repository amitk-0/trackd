require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  setup do
    @user = users(:user_one)
    @user.update(password: 'ComplexPwd123')
  end

  test 'should create a session when password is correct' do
    post login_url, params: { email: @user.email, password: 'ComplexPwd123' }
    assert_redirected_to tasks_path
    assert_equal @user.id, session[:user_id]
  end

  test 'should NOT create a session when password is incorrect' do
    post login_url, params: { email: @user.email, password: 'wrong_password' }
    assert_response :unauthorized
    assert_equal 'Email or password is incorrect', flash[:alert]
    assert_nil session[:user_id]
  end

  test 'should destroy session on logout' do
    delete logout_url
    assert_redirected_to root_path do |redirect|
      assert_equal 'Logged Out!', flash[:notice]
    end
    assert_nil session[:user_id]
  end
end

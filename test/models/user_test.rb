require "test_helper"

class UserTest < ActiveSupport::TestCase
  fixtures :users
  test 'invalid without first_name' do
    user = users(:user_one)
    user.first_name = nil
    assert_not user.valid?
    assert_equal user.errors.full_messages.first, "First name can't be blank"
  end

  test 'invalid without last_name' do
    user = users(:user_one)
    user.last_name = nil
    assert_not user.valid?
    assert_equal user.errors.full_messages.first, "Last name can't be blank"
  end

  test 'invalid without correct email' do
    user = users(:user_one)
    user.email = nil
    assert_not user.valid?
    assert_equal user.errors.full_messages.first, "Email can't be blank"
  end

  test 'invalid without correct email address format' do
    user = users(:user_one)
    user.email = '@example.com'
    assert_not user.valid?
    assert_equal user.errors.full_messages.first, "Email is invalid"
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  deleted_at      :datetime
#  email           :string
#  first_name      :string
#  is_admin        :boolean          default(FALSE)
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

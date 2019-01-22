require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post auth_register_path, params: { user: { email: @user.email, username: @user.username, password: @user.password_digest } }, as: :json
    end

    assert_response 201
  end


  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, username: @user.username, password: @user.password_digest } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user), as: :json
  #   end

  #   assert_response 204
  # end
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(username: "TestUser", email: "test@user.com",
						 password: "testpwd", password_confirmation: "testpwd")

	end

	test "Should be valid" do
		@user.valid?
	end

	# test "name should be present" do
	# 	@user.username = " "
	# 	assert @user.valid?
	# end
end

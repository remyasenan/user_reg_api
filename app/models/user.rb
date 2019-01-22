class User < ApplicationRecord
	has_and_belongs_to_many :groups
	validates :username, presence: true
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: EMAIL_REGEX}
	validates :password, presence: true
	has_secure_password

	def User.digest(string)
    	BCrypt::Password.create(string)
	end
end

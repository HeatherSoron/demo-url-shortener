require 'bcrypt'

class User
	include Mongoid::Document

	field :username, type: String
	field :pw_hash, type: String # bcrypt hash! make it secure - don't be daft

	has_many :short_link

	# use this to check if a passed-in plaintext password is valid
	def check_password(pw)
		return self.pw_hash && BCrypt::Password.new(self.pw_hash) == pw
	end

	# use this for setting the password hash, rather than doing that manually
	def set_password(pw)
		# may want to increase cost over time
		self.pw_hash = BCrypt::Password.create(pw, :cost => 12)
	end
end

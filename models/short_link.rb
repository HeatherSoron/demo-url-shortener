require 'securerandom'

class ShortLink
	include Mongoid::Document

	field :url, type: String
	field :slug, type: String

	field :use_count, type: Numeric
	field :created_at, type: Time
	field :last_used_at, type: Time

	belongs_to :user

	# self-saves (debatable whether we want to always save, in here; or leave that to the caller)
	def track_usage
		self.use_count += 1
		self.last_used_at = Time.now
		self.save
	end

	def set_unique_slug
		self.slug = nil
		while slug.nil? || ShortLink.where({slug: slug}).count > 0
			p slug
			self.slug = SecureRandom.urlsafe_base64(3) # 3 bytes = 4 chars, in practice
		end
	end
end

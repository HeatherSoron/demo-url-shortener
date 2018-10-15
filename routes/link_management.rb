get '/app/links' do
	popular_links = ShortLink.where({}).sort({use_count:-1}).limit(10)
	haml :links, locals: { popular_links: popular_links }
end

post '/app/shorten-url' do
	link = ShortLink.new
	
	link.url = params[:url]
	link.set_unique_slug
	link.created_at = Time.now
	link.use_count = 0

	link.save

	haml :shorten, locals: { new_link: link }
end

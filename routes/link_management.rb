# purpose - overview page
get '/app/links' do
	popular_links = ShortLink.where({user_id: session[:user_id]}).sort({use_count:-1}).limit(10)
	haml :links, locals: { popular_links: popular_links }
end

# purpose - create a new shortened link. (non-ajax, as the specs don't actually require any client-side logic)
post '/app/shorten-url' do
	link = ShortLink.new
	
	link.url = params[:url]
	link.set_unique_slug
	link.created_at = Time.now
	link.use_count = 0
	link.user_id = session[:user_id]

	link.save

	haml :shorten, locals: { new_link: link }
end

# purpose - detailed stats on a link
get '/app/stats/:slug' do |slug|
	link = ShortLink.where({user_id: session[:user_id], slug: slug}).first
	
	haml :stats, locals: { link: link }
end

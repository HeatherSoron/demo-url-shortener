get '/app/links' do
	HEADER_LIST = [
		{
			display_name: "Shortened",
			field_name: "slug",
		},
		{
			display_name: "Original URL",
			field_name: "url",
		},
	]
	haml :links, locals: { table_cols: HEADER_LIST, popular_links: [] }
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

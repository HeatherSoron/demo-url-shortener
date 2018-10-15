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

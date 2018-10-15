# match all the characters valid in our slugs
get %r{/(?<slug>[A-Za-z0-9_=-]+)/?} do
	link = ShortLink.where({slug: params[:slug]}).first
	if (!link)
		halt 404
	end

	# MAJOR concurrency issue here!
	link.track_usage

	return link.url
end

# match all the characters valid in our slugs
get %r{/(?<slug>[A-Za-z0-9_=-]+)/?} do
	link = ShortLink.where({slug: params[:slug]}).first
	if (!link)
		halt 404
	end

	# TODO MAJOR concurrency issue here!
	link.track_usage

	redirect link.url, 303
	return nil
end

Created as a Github-accessible demo, by request.

# Running the app
* Set up `config/mongoid.yml` as appropriate, pointed to a MongoDB instance (for test purposes, the sample file would work)
* Set up `config/session_key.secret` with an appropriate session key (for non-secure test purposes, random hex would work)
* Run `bundle install`
* Run `MONGOID_ENV=development ruby create_indexes.rb` (or with the appropriate environment) to create DB indexes (technically optional, but recommended)
* Run `ruby index.rb`, which starts a fairly vanilla Sinatra app (command line arguments work as normal for Sinatra)


# Using the app
Go to `$HOST/auth/login` to register a user, or login.

After logging in, you'll be taken to the overview page (`$HOST/app/links`), where you can create links, and view the most-frequently-used links.

You are able to shorten links and view stats on links. If desired, you can also specify what you want the shortened portion to be (but it must be unique!).


# Implementation notes

* To prevent XSS on *our* site (which I presume to be in-scope of the specs, by default), escaping has been turned on by default in the template engine
* A couple places would have been a tad nicer with ajax, but it appeared non-essential, so I've elected to skip JS altogether


# Known issues (current, in rough order of priority)

* Easily-reproduced race condition: when incrementing use count of a link, it would be *much* better to use Mongo's `$inc` (to increment, for concurrency), whereas I think Mongoid mostly makes use of a direct set (so multiple users will clobber each others' increments). 
* Only the "most recent used" links are shown on the overview page (currently set to 10). Having a full list may be useful, but appears to be out-of-scope currently (separate page might work).
* Link protocol is not validated - this probably doesn't lead to an XSS vulnerability, due to how the redirect works, but still worth assessing the impact of this (and maybe doing validation, similar to slug uniqueness of user-supplied slugs)
* Slugs should ideally be validated as URL-safe (alphanumeric, etc.)
* Creation-time race condition: uniqueness checks (on URL slugs or username) haven't been made threadsafe
* Lack of automated tests. (due to the limited number of components which don't touch the DB or the web request, E2E/integration tests are probably where I'd start. Or possibly currently-failing tests for some of the issues above)
* Session/user management is possibly a little wonky. Works, but another once-over might be good. 
* Mongoid isn't the best ODM, though this was discovered (on a previous project) only after using it for a while (on this project, it's basically been lifted across, due to desire to work with known tools rather than trial a probably-better tool)


# Future issues

* Random slugs are hardcoded to 4 characters (3 bytes in base64). Before we hit `64^4 / 2` links in the system, this should be increased, to keep the rate of collisions low.
* I have a feeling that doing a DB save before the redirect may lead to slowness in the future. Possible idea to fix this: use threads, and do the DB update only after sending the HTTP response. (I've done threaded logic before for background processes, which *seems* like it would translate to this scenario, but this is a future problem to tackle)
* Users will probably want a password reset of some sort


# Potential (programmer) idiosyncracies

The codebase uses tab-based indentation, due to personal preference and a lack of collaborators. That being said, team style guide > tabs > spaces. When working in a team where spaces are used, I'll happily reconfigure my editor in order to keep stuff consistent.

There may be some JavaScript-style coding habits present, since I'm comfortable with both that and Ruby. (of course, hopefully no bad habits from PHP - I do understand it, but prefer Ruby and JS)

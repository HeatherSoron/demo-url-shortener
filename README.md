# Known issues (current)

* Reflected XSS vulnerability: the user can supply a `javascript:` URL and cause problems that way
* Creation-time race condition: uniqueness checks (on URL slugs) haven't been made threadsafe

# Future issues

* Random slugs are hardcoded to 4 characters (3 bytes in base64). Before we hit `64^4 / 2` links in the system, this should be increased, to keep the rate of collisions low.

# Potential idiosyncracies

The codebase uses tab-based indentation, due to personal preference and a lack of collaborators. That being said, team style guide > tabs > spaces. When working in a team where spaces are used, I'll happily reconfigure my editor in order to keep stuff consistent.

There may be some JavaScript-style coding habits present, since I'm comfortable with both that and Ruby. (hopefully nothing from PHP - I do understand it, but prefer Ruby and JS)

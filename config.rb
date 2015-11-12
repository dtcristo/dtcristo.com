###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml',  layout: false
page '/*.json', layout: false
page '/*.txt',  layout: false

# Disable directory_index for 404 page
page '/404.html', directory_index: false

###
# Helpers and extensions
###

# Time.zone = 'UTC'

activate :blog do |blog|
  blog.permalink = '{title}'
  # Matcher for blog source files
  blog.sources = 'articles/{year}-{month}-{day}-{title}.html'
  blog.layout = 'article'
  blog.default_extension = '.md'
end

# Pretty URLs (https://middlemanapp.com/advanced/pretty_urls/)
activate :directory_indexes
set :trailing_slash, false

# Markdown and syntax highlighting
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

# Deployment settings
activate :s3_sync do |s3_sync|
  s3_sync.bucket = 'dtcristo.com'
  s3_sync.region = 'ap-southeast-2'
end

###
# Site settings
###
set :site_url, 'http://dtcristo.com/'
set :site_title, 'David Cristofaro'
set :site_subtitle, 'Software developer, technology enthusiast, music lover'
set :profile_text, %q(I'm a full time software developer living and working in Melbourne, Australia. I'm also a passionate science &amp; technology enthusiast and love to stay up to date. And all the time, I'm listening to the latest indie and electronic music.)
set :site_author, 'David Cristofaro'

# Usernames
set :github_username, 'dtcristo'
set :keybase_username, 'dtcristo'
set :twitter_username, 'dtcristo'
set :linkedin_username, 'dtcristo'
set :lastfm_username, 'dtcristo'
set :spotify_username, 'dtcristo'

set :disqus_shortname, 'dtcristo'
set :google_analytics, 'UA-60447486-1'

# Custom asset directories
set :partials_dir, 'partials'

# Development-specific configuration
configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify JavaScript on build
  activate :minify_javascript
end

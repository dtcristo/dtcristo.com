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

# Add dynamic Netlify headers configuration
proxy '_headers', 'netlify_headers', ignore: true

###
# Helpers and extensions
###

helpers do
  # Builds a page title from the article title + site title
  def page_title
    if current_article && current_article.title
      current_article.title + ' | ' + config[:site_title]
    else
      config[:site_title]
    end
  end
  # Renders component partials
  def component(path, locals={})
    partial "components/#{path}", locals
  end
end

activate :blog do |blog|
  blog.permalink = '{title}'
  # Matcher for blog source files
  blog.sources = 'articles/{year}-{month}-{day}-{title}.html'
  blog.layout = 'article'
  blog.default_extension = '.md'
end

# Markdown and syntax highlighting
activate :syntax
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

# Use commit time from git for sitemap.xml and feed.xml
activate :vcs_time

###
# Site settings
###
set :site_url, 'https://dtcristo.com/'
set :site_title, 'David Cristofaro'
set :site_subtitle, 'Software developer, technology enthusiast, music lover'
set :profile_text, %q(I'm a software developer living and working in Melbourne, Australia. I'm also a passionate science &amp; technology enthusiast and love to stay up to date. All the while listening to the latest indie and electronic music.)
set :site_author, 'David Cristofaro'
set :site_id, 'uri:uuid:2d2e7b7d-85b6-462c-9d78-243d6921ff69'

# Usernames
set :github_username, 'dtcristo'
set :keybase_username, 'dtcristo'
set :twitter_username, 'dtcristo'
set :linkedin_username, 'dtcristo'
set :lastfm_username, 'dtcristo'
set :spotify_username, 'dtcristo'

# set :disqus_shortname, 'dtcristo'
set :disqus_shortname, nil
# set :google_analytics, 'UA-60447486-1'
set :google_analytics, nil

###
# Environment settings
###
# Development-specific configuration
configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html

  # Improve cacheability by using asset hashes in filenames
  activate :asset_hash
end

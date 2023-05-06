require 'sinatra'
require 'httparty'
require 'json'
require 'sinatra/json'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

GNEWS_API_KEY = ENV['GNEWS_API_KEY']
CACHE_EXPIRATION = 300

$cache = {}
$cache_expiration = {}

helpers do
  def fetch_articles(query = nil, max_results = 10)
    url = "https://gnews.io/api/v4/top-headlines?category=general&apikey=#{GNEWS_API_KEY}&max=#{max_results}"
    url += "&q=#{query}" if query

    # Check cache and expiration
    if $cache.key?(url) && Time.now.to_i - $cache_expiration[url] < CACHE_EXPIRATION
      return $cache[url]
    end

    response = HTTParty.get(url)
    articles = JSON.parse(response.body)['articles']

    # Update cache
    $cache[url] = articles
    $cache_expiration[url] = Time.now.to_i
  end
end

get '/articles' do
  max_results = params['max_results'] || 10
  json fetch_articles(nil, max_results)
end

get '/search' do
  query = params['query']
  max_results = params['max_results'] || 10

  json fetch_articles(query, max_results)
end

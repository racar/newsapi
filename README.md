# Simple API builded in sinatra.rb

## Hot it works?
1. Be sure you get a APIKEY from https://gnews.io/
2. set the apikey in a env var named: GNEWS_API_KEY (export GNEWS_API_KEY=your_api_key_here)
3. Install gems: bundle install
4. Run sinatra: bundle exec ruby app.rb 
5. Test examples on local host:
- http://localhost:4567/search?query=climate%20change
- http://localhost:4567/articles?max_results=5


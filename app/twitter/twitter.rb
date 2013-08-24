require 'rest_client'
require 'base64'
require 'json'


class Tweet

  attr_reader :tweets

  def initialize(twitter_handle)
	@app_key = 'xxxx'
	@app_secret = 'xxxx'
	@encoded = ''
	base64_encode
	@token_string = ''
	get_token
    @tweets = {}
	get_tweets(twitter_handle)
  end

  def base64_encode
  	key = URI::encode(@app_key)
	secret = URI::encode(@app_secret)
	@encoded = Base64.strict_encode64("#{key}:#{secret}".force_encoding('UTF-8'))
  end

  def get_token
    response = RestClient::Resource.new "https://api.twitter.com/oauth2/token"

    options = {}
	options['Authorization'] = "Basic #{@encoded}"
	options['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'

	token_response = response.post('grant_type=client_credentials', options)

	token_hash = JSON.parse(token_response)
	@token_string = "Bearer " + "#{token_hash['access_token']}"
  end

	# Request token URL	https://api.twitter.com/oauth/request_token
	# Authorize URL	https://api.twitter.com/oauth/authorize
	# Access token URL	https://api.twitter.com/oauth/access_token
	

  def get_tweets(twitter_handle)
    get_request = RestClient::Resource.new "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{twitter_handle}&count=10include_rts=false"
	tweets_object = get_request.get({ "Authorization" => @token_string })

	@tweets = JSON.parse(tweets_object)
  end

end

# Tweet.new('rheedio')


# def list_tweets(twitter_handle)
#   tweets.each do |mapping|
#     mapping.each do |k, v|
#       if k == 'text'
# 	    puts v
# 	  end
#     end
#   puts
#   end
# end
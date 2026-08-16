require 'net/http'
require 'json'
require 'uri'

def post_request(url, body_params = {})
  uri = URI(url)

  request = Net::HTTP::Post.new(uri)
  request['Content-Type'] = 'application/json'
  request.body = body_params.to_json

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"

  body = JSON.parse(response.body)

  if body == {} || body == []
    puts body.to_json
  else
    puts JSON.pretty_generate(body)
  end
end

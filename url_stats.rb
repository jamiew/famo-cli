# Fetch famo stats for a website url
#
# Usage:
#   bundle exec ruby url_stats.rb http://fffff.at

require 'uri'
require 'multi_json'

url = ARGV[0]

if url.nil? || url.empty?
  $stderr.puts "You must specify a URL like 'fffff.at' as argument"
  exit 1
end

url_with_protocol = (url =~ /^http/ ? url : "http://#{url}")
url_without_protocol = url_with_protocol.gsub(/^https?\:\/\//,'')

# Facebook
# url = "https://graph.facebook.com/?ids=#{url_with_protocol}"
# url = "https://api.facebook.com/method/fql.query?query=SELECT%20total_count,like_count,comment_count,share_count,click_count%20FROM%20link_stat%20WHERE%20url=%22#{url_with_protocol}%22&format=json"

# Twitter
# url = "http://urls.api.twitter.com/1/urls/count.json?url=#{URI.escape(url_with_protocol)}"

# All-in-one by hacking this third party service
# POST http://www.likeexplorer.com/ajax/get_social_analytics?data[url]=...
# curl -d"data[url]=vhx.tv" http://www.likeexplorer.com/ajax/get_social_analytics
res = `curl -s -d"data[url]=#{url_without_protocol}" http://www.likeexplorer.com/ajax/get_social_analytics`
json = MultiJson.load(res)
analytics = json && json['analytics']
puts analytics

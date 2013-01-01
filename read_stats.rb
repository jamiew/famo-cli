require 'json'
require 'pp'

files = Dir.glob(File.dirname(__FILE__) + '/stats/**/*.json')

date_stats = {}
url_stats = {}
group_stats = {}

files.each do |file|
  data = File.open(file).read
  json = JSON.parse(data) rescue ($stderr.puts "Error parsing #{file}: #{data.inspect}")
  next if json.nil? || json.empty?
  # puts json.inspect

  parts = file.split('/')
  group = parts[2]
  url = parts[3]
  filename = parts[4]
  date = filename.gsub(/_0000\.json$/, '')

  date_stats[date] ||= {}
  date_stats[date][url] = json
  # stats[date][group][url] = json

  url_stats[url] ||= {}
  group_stats[group] ||= {}
  json.each{|k,v|
    url_stats[url][k]     ||= 0
    group_stats[group][k] ||= 0
    url_stats[url][k]     += v.to_s.gsub(',','').to_i
    group_stats[group][k] += v.to_s.gsub(',','').to_i
  }


end

# puts "By date:"
# pp date_stats

# puts "\n\nBy URL:"
# pp url_stats

# puts "\n\nBy group:"
# pp group_stats

csv = date_stats.map


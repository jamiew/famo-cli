
require 'yaml'
require 'pp'

targets = YAML.load(File.open('urls.yml').read)
pp targets

targets.each do |group,urls|

  puts "Processing #{urls.length} sites for #{group} ..."
  FileUtils.mkdir_p("stats/#{group}")

  urls.each do |url|
    puts "#{url} ..."
    output = `bundle exec ruby url_stats.rb #{url}`
    # datestamp = Time.now.strftime('%Y_%m_%d')
    datestamp = Time.now.strftime('%Y_%m_%d_%H%M')
    puts output

    # Write to a datestamped JSON file, we'll do more with this later
    filename = "stats/#{group}/#{datestamp}.json"
    File.open(filename, 'w') { |file| file.write(output) }
  end
end



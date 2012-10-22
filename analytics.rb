# Experimenting with garb (Google Analytics reports)
# Assumes jamiew fork: https://github.com/jamiew/garb

require 'pp'
require 'yaml'
require 'garb'
require 'garb-reporter'

# Download http://curl.haxx.se/ca/cacert.pem to use SSL
ca_cert = File.join(File.dirname(__FILE__), '/cacert.pem')
if File.exists?(ca_cert)
  Garb.ca_cert_file = ca_cert
  secure = true
else
  puts "cacert.pem is missing, NOT using SSL"
  secure = false
end

# Load config
raise 'Copy config.sample.yml to config.yml and set things up' if !File.exists?('config.yml')
config = YAML.load(File.open('config.yml').read)
username = config['ganalytics']['username']
password = config['ganalytics']['password']
profile_id = config['ganalytics']['profile_id']
raise "Missing required config options: username, password, profile_id" if username.nil? || password.nil? || profile_id.nil?

session = Garb::Session.login(username, password, secure: secure)

# All data
# accounts = Garb::Management::Account.all
# properties =  Garb::Management::WebProperty.all
# profiles = Garb::Management::Profile.all
# goals = Garb::Management::Goal.all

# Load visits and goals for a couple days
profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == profile_id }
profile_goals = profile.goals
report = GarbReporter::Report.new(profile)

start_date = Date.parse('2012/10/13')
end_date = Date.parse('2012/10/15')

visits = report.visits_by_date(start_date: start_date, end_date: end_date)
pp visits

goals = report.goal_completions_all_by_date(start_date: start_date, end_date: end_date)
pp goals




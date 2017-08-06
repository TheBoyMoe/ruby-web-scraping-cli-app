# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meetup_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = 'meetup-scraper'
  spec.version       =  MeetupScraper::VERSION
  spec.date          = '2017-08-06'
  spec.authors       = ["Bill Fero"]
  spec.email         = ["billfero@gmail.com"]
  spec.summary       = %q{Scrape Meetup.com site.}
  spec.description   = %q{Search Meetup.com and scape the details of the latest meetups in your area.}
  spec.files         = [
    'lib/meetup_scraper.rb',
    'lib/meetup_scraper/cli_methods.rb',
    'lib/meetup_scraper/command_line_interface.rb',
    'lib/meetup_scraper/event.rb',
    'lib/meetup_scraper/scraper.rb',
    'lib/meetup_scraper/version.rb'
  ]
  spec.homepage      = "https://github.com/theBoyMo/ruby-web-scraping-cli-app"
  spec.license       = "MIT"
  spec.executables << 'meetup-scraper'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry', "~> 0"

  spec.add_dependency 'nokogiri', '1.6.6.2'
end

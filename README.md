# Meetup Web Scraper CLI gem

## Description
Search Meetup.com for events near you via a command line interface.

## Objectives

1. Provide a CLI
2. CLI must provide access to data from a web page.
3. The data provided must go at least one level deep, generally by showing the user a list of available data and then being able to drill down into a specific item.
4. Use good OO design patterns.
5. Convert the app into a gem

## Installation

Install the gem as directed below, or download the repo and from the root of the project execute ./bin/meetup-scraper to launch the cli and follow the prompts.

```ruby
  $ gem install meetup-scraper
```

## Usage

Execute the following command and follow the prompts.

```ruby
  $ meetup-scraper
```

Enter you subject of interest, you local town and the distance your willing to travel. A list of suitable matches will be displayed, if any are found. You can drill in further into any event by entering that item's number, otherwise repeat the search or exit.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

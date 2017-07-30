=begin
  url: https://en.wikipedia.org/wiki/List_of_members_of_the_Forbes_400

  url: 'https://www.meetup.com/find/events/?allMeetups=false&keywords=javascript&radius=2&userFreeform=London%2C+United+Kingdom'

=end

class Scraper

  def self.fetch_meetup_list(url)
    doc = Nokogiri::HTML(open(url))
    # TODO change to event-listing not row-item
    items = doc.css('.searchResults .event-listing-container .event-listing .row-item')

    count = 1
    items.collect do |item|
      event = {}
      date_time = {}
      title = item.css('.chunk a.event span').inner_text
      if title != ''
        event[:count] = count
        event[:title] = title
        event[:organiser] = item.css('.chunk .text--labelSecondary a span').inner_text
        event[:url] = item.css('a').first.attr('href')
        num_attending = item.css('.text--secondary .attendee-count').inner_text
        event[:num_attending] = num_attending.slice(0, 6).gsub(/[^\d]/, '')
        count += 1
      end
      time = item.css('time').text
      if time != ''
        date_time[:count] = count
        date_time[:time] = time
        date_time[:date] = item.css('time').attr('datetime')
      end

      puts "#{event}"
      event
    end.select {|event| event.size > 0 && event[:count]}

  end

end

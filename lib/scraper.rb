=begin
  url: https://en.wikipedia.org/wiki/List_of_members_of_the_Forbes_400

  url: 'https://www.meetup.com/find/events/?allMeetups=false&keywords=javascript&radius=2&userFreeform=London%2C+United+Kingdom'

=end

class Scraper

  def self.fetch_meetup_list(url)
    doc = Nokogiri::HTML(open(url))
    items = doc.css('.searchResults .event-listing-container .event-listing')

    count = 1
    items.collect do |item|
      event = {}
      title = item.css('.chunk a.event span').inner_text
      if title != ''
        event[:count] = count
        event[:title] = title
        event[:organiser] = item.css('.chunk .text--labelSecondary a span').inner_text
        event[:url] = item.css('a').first.attr('href')
        num_attending = item.css('.text--secondary .attendee-count').inner_text
        event[:num_attending] = num_attending.strip.slice(0, 4).gsub(/[^\d]/, '')
        count += 1
      end
      time = item.css('.text--secondary time').text
      if time != ''
        event[:time] = time
        event[:date] = item.css('time').attr('datetime').value
      end
      event[:location] = item.css('.text--secondary')[1].css('a').text.strip
      puts "#{event}"
      event
    end.select {|event| event.size > 0 && event[:count]}

  end

end

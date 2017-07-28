=begin
  url: https://en.wikipedia.org/wiki/List_of_members_of_the_Forbes_400

=end
class Scraper

  def self.fetch_rich_list(url)
    doc = Nokogiri::HTML(open('https://en.wikipedia.org/wiki/List_of_members_of_the_Forbes_400'))
    table = doc.css('div.mw-content-ltr').css('table.wikitable')[1]
    rows = table.css('tr') # 1st row consists of headers
    rows.each do |row|
      puts row
      puts '-----------------------------------------'
    end
  end
end

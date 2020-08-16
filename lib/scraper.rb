require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

@@scraped_students = []

  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
# binding.pry
    doc.css(".student-card").each do |i|
       temp_hash = {}
   
      name = i.css("h4").text.strip
      location = i.css("p").text.strip
      profile_url = i.css("a").attr('href').text 
          temp_hash[:name] = name
          temp_hash[:location] = location
          temp_hash[:profile_url] = profile_url
  @@scraped_students.push(temp_hash)
      end
  @@scraped_students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
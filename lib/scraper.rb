require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

@@scraped_students = []
@@scraped_profile = {}

  def self.scrape_index_page(index_url)
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)

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
  end # ends method 

 def self.scrape_profile_page(profile_url)
   scraped_profile = {}
   html = open(profile_url)
    doc = Nokogiri::HTML(html)
    s_media = []
    doc.css(".social-icon-container a").each do |i|
     s_media.push(i)
   end
   i = 0 
   j = s_media.length
   
   while i < j-1 do 
     scraped_profile[:twitter] = s_media[i].attr('href') if s_media[i].attr('href').include?("twitter")
     scraped_profile[:linkedin] = s_media[i].attr('href') if s_media[i].attr('href').include?("linkedin")
    scraped_profile[:github] = s_media[i].attr('href') if s_media[i].attr('href').include?("github")
     scraped_profile[:blog] = s_media[i].attr('href') if (i == j-1) && j-1 > scraped_profile.length
     i += 1
   end
  
    scraped_profile[:profile_quote] = doc.css(".profile-quote").text
    scraped_profile[:bio] = doc.css("div.description-holder p").text
    scraped_profile
    #binding.pry
 end # ends method 
   
  

end #ends Class 
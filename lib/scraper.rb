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
   html = open(profile_url)
    doc = Nokogiri::HTML(html)
    s_media = []
    doc.css(".social-icon-container a").each do |i|
     s_media.push(i)
   end
   s_media.each do |i|
     @@scraped_profile[:twitter] = i.attr('href') if i.attr('href').include?("twitter")
     @@scraped_profile[:linkedin] = i.attr('href') if i.attr('href').include?("linkedin")
    @@scraped_profile[:github] = i.attr('href') if i.attr('href').include?("github")
     @@scraped_profile[:blog] = i.attr('href') if i.attr('href').inlude?("blog")
    
      
      
    
     end
   #end
   binding.pry
   
 
   
 end # ends method 
   
  

end #ends Class 
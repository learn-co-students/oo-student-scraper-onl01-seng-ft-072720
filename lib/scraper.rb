require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    std_array = []
    doc = Nokogiri::HTML(open(index_url))
    
    students = doc.css(".student-card")
    std_array = students.collect do |student|
      std_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").first["href"]
      }
    end
    std_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css(".social-icon-container")
    person_hash = {}
    social_links.each do |social|
      link = social.children.css("a").attribute('href').value
      binding.pry
    end
      

    


      # if link.includes?("linkedin")
      # person_hash[:linkedin] = 
      # :twitter => link.css("a")[0]["href"],
      # :linkedin => link.css("a")[1]["href"],
      # :github => link.css("a")[2]["href"],
      # :blog => link.css("a")[3]["href"],
      # :profile_quote => doc.css(".profile-quote").text,
      # :bio => doc.css("p").text
      
  end


  
end 

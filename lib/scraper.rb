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
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map {|el| el.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link

      end
    end

    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p" ).text if profile_page.css("div.bio-content.content-holder div.description-holder p" )

    student

  end 

end

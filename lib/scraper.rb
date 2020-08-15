# require 'nokogiri'
require 'open-uri'
require 'pry'

# html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
# doc = Nokogiri::HTML(html)

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))

    page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name, :location => location, :profile_url => profile_url}
      students << student_info
    end
    students
      # binding.pry
    end
    
  

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    # binding.pry
    links = page.css(".social-icon-container a").collect do |icon|
      icon.attribute("href").value
      
  
    end

      links.each do |link|
        
        if link.include?("twitter")
          student[:twitter] = link
        elsif
          link.include?("linkedin")
          student[:linkedin] = link
          elsif
            link.include?("github")
          student[:github] = link
          else
          student[:blog] = link
          
          end
        end
        student[:profile_quote] = page.css(".profile-quote").text
        # profile.css(".social-icon").text
        student[:bio] = page.css("div.description-holder p").text
        # profile = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, :profile_quote => profile_quote, :bio => bio}
        student
        
      end
    
  
end

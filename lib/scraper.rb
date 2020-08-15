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
    page = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"))
    student = {}
    profile = page.css("social-icon-container a").collect do |icon|
      icon.attribute("href").value
      profile.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif
          link.include?("linkedin")
          student[:linkedin] = link
          elsif
            link.include?("github")
          student[:github] = link
          elsif
            link.include?("blog")
          student[:blog] = link
          
          end
        end
        student[:profile_quote] = page.css(".profile-quote")
        profile.css(".social-icon").text
        student[:bio] = page.css("div.description-holder p").text
        binding.pry
        student
      end
    
  
end
end
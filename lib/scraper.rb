require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
       doc.css(".student-card").each do |student|
         student_hash = {}
       student_hash[:name] = student.css("h4.student-name").text
       student_hash[:location] = student.css("p.student-location").text
       student_hash[:profile_url] = student.css("a").attribute("href").text
      # binding.pry
        students_array.push(student_hash)

     end 
     
    students_array
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    doc.css(".main-wrapper.profile").each do |student|
    social = student.css(".social-icon-container a").each do |node|
      if node.attr("href").include?("twitter")
        scraped_student[:twitter] = node.attr("href")
      elsif node.attr("href").include?("linkedin")
        scraped_student[:linkedin] = node.attr("href")
      elsif node.attr("href").include?("github")
        scraped_student[:github] = node.attr("href")
      else 
        scraped_student[:blog] = node.attr("href")
        nil
      end 
     end 
     scraped_student[:profile_quote] = student.css("div.profile-quote").text
     scraped_student[:bio] = student.css("p").text
   end 
   scraped_student
  end
 

    
      
  

end


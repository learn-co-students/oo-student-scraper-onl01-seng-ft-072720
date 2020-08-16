require 'open-uri'
require 'pry'
require 'json'

class Scraper
@@students = []
@@student_profiles = []
def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  doc.css(".student-card").each do |student|
  scraped_student = {
  profile_url: student.css("a").collect {|student| student["href"]}[0],   #doc.css(".student-card a").collect {|link| link["href"]}
  name: student.css("h4").text,   #doc.css('h4').collect {|name| name.text}
  location: student.css("p").text,
}   #doc.css('p').collect {|location| location.text}
  @@students.push(scraped_student)
  end
  @@students
end

def self.scrape_profile_page(profile_url)
  doc = Nokogiri::HTML(open(profile_url))
  result = nil
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
      end
        scraped_student[:profile_quote] = student.css(".vitals-text-container .profile-quote").text
        scraped_student[:bio] = student.css(".details-container p").text
        # binding.pry
      result = scraped_student
    end
  end
  result
end


end

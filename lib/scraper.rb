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
  doc.css(".main-wrapper.profile").each do |student|
    social = student.css(".social-icon-container a").collect {|node| node.attr("href")}
    quote = student.css(".vitals-text-container .profile-quote").collect {|node| node.text}
    bio = student.css(".details-container p").collect {|node| node.text}
    scraped_student = {
    twitter: social[0],
    linkedin: social[1],
    github: social[2],
    blog: social[3],
    profile_quote: quote[0],
    bio: bio[0]
  }
  # binding.pry
  result = scraped_student
  end
  result
end

end

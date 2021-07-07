require 'open-uri'
require 'pry'
require 'json'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students_data = doc.css(".student-card")
    students = []
    students_data.each do |s|
      students_hash = {}
      students_hash[:name] = s.css(".student-name").text
      students_hash[:location] = s.css(".student-location").text
      students_hash[:profile_url] = s.css("a").attr("href").value
      students << students_hash
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_data = doc.css(".main-wrapper")
    profile_hash = {}

    profile_data.each do |d|
      profile_hash[:profile_quote] = d.css(".profile-quote").text
      profile_hash[:bio] = d.css(".description-holder p").text
        d.css(".social-icon-container a").each do |x|
          case
          when x.attr("href").include?("twitter")
            profile_hash[:twitter] = x.attr("href")
          when x.attr("href").include?("linkedin")
            profile_hash[:linkedin] = x.attr("href")
          when x.attr("href").include?("github")
            profile_hash[:github] = x.attr("href")
          else
            profile_hash[:blog] = x.attr("href")
          end
        end
      end
      profile_hash
  end
end

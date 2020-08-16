class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      @name = student_hash[:name]
      @location = student_hash[:location]
      @twitter = student_hash[:twitter]
      @@all.push(self)
      
    end
   # binding.pry
  end

  def self.create_from_collection(students_array)
students_array.each do |i|
  Student.new(i)
end
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end


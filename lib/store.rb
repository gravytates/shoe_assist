class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 100}})
  validates_uniqueness_of :name, case_sensitive: false
  before_save(:titlecase)

private


  define_method(:titlecase) do
    noncaps = ["and", "as", "at", "but", "buy", "for", "from", "if", "in", "into", "is", "like", "near", "nor", "of", "off", "on", "once", "onto", "or", "over", "past", "so", "than", "that", "till", "to", "up", "upon", "with", "when", "yet"]
    words = self.name.split(" ")
    words.each do |word|
binding.pry
      noncaps.each do |noncap|
        if word.include?(noncap)
          word = word
        else
          word.capitalize!
        end
      end
    end
    self.name = words.join(" ")
  end
end

class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates(:name, {presence: true, length: { maximum: 100}})
  validates_uniqueness_of :name, case_sensitive: false
  validates(:price, {presence: true, length: { maximum: 6}})
  before_save(:titlecase, :currency_change)


  def titlecase
    words = self.name.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(" ")
  end

  # method to change price from fixnum/float style into currency style. method is run twice by app.rb upon checking for errors (see: if @brand.save), so method needs to only run for inputs where it has not already been applied
  def currency_change
    if !self.price.include? ("$")
      self.price = '$' + sprintf("%.2f", self.price)
    end
  end
end

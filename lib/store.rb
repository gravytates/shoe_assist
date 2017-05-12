class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
  validates(:name, {presence: true, case_sensitive: false, length: { maximum: 100}})
  validates_uniqueness_of :name, case_sensitive: false
  before_save(:titlecase)

private

  def titlecase
    noncaps = ["and", "as", "at", "but", "buy", "for", "from", "if", "in", "into", "is", "like", "near", "nor", "of", "off", "on", "once", "onto", "or", "over", "past", "so", "than", "that", "till", "to", "up", "upon", "with", "when", "yet"]
    new_name = self.name.split(' ')
      .each{|word| word.capitalize! if ! noncaps.include? word }
      .join(' ')
    self.name = new_name
  end
end


class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates(:name, {presence: true, length: { maximum: 100}})
  validates_uniqueness_of :name, case_sensitive: false
  validates(:price, {presence: true, length: { maximum: 6}})
  before_save(:titlecase, :currency_change)


  def titlecase
    noncaps = ["and", "as", "at", "but", "buy", "for", "from", "if", "in", "into", "is", "like", "near", "nor", "of", "off", "on", "once", "onto", "or", "over", "past", "so", "than", "that", "till", "to", "up", "upon", "with", "when", "yet"]
    new_name = self.name.split(' ')
      .each{|word| word.capitalize! if ! noncaps.include? word }
      .join(' ')
    self.name = new_name
  end

  # method to change price from fixnum/float style into currency style. method is run twice by app.rb upon checking for errors (see: if @brand.save), so method needs to only run for inputs where it has not already been applied
  def currency_change
    if !self.price.include? ("$")
      self.price = '$' + sprintf("%.2f", self.price)
    end
  end
end

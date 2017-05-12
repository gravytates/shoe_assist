class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
  validates(:name, {presence: true, length: { maximum: 100}})
  before_save(:titlecase)

private
  define_method(:titlecase) do
    words = self.name.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(" ")
  end
end

class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates(:name, {presence: true, length: { maximum: 100}})
  before_save(:titlecase)

private
  def titlecase
    words = self.name.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(" ")
  end
end

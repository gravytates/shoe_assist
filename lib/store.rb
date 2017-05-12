class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
end

class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
end

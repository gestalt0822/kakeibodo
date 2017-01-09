class Category < ActiveRecord::Base
  has_many :sorts, dependent: :destroy
end

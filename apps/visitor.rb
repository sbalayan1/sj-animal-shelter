class Visitor < ActiveRecord::Base
    belongs_to :location 
    has_many :adoptions 
    has_many :animals, through: :adoptions
end 
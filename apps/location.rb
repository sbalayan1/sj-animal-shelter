class Location < ActiveRecord::Base
    has_many :shelters 
    has_many :visitors
end 
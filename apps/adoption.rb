class Adoption < ActiveRecord::Base
    belongs_to :animal 
    belongs_to :visitor 
end 
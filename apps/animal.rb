class Animal < ActiveRecord::Base
    belongs_to :shelter 
    has_many :adoptions 
    has_many :visitors, though: :adoptions
end 
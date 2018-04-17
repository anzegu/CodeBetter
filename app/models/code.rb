class Code < ApplicationRecord
  belongs_to :language
  belongs_to :problem
  
  attr_accessor :input
end

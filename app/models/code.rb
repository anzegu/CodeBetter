class Code < ApplicationRecord
  belongs_to :language
  belongs_to :problem
end

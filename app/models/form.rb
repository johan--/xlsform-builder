class Form < ActiveRecord::Base
  validates :form_title, presence: true
end

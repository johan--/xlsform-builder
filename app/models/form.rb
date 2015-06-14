class Form < ActiveRecord::Base
  has_many :fields

  validates :form_title, presence: true

  scope :descending_update_time, -> { order(updated_at: :desc) }
end

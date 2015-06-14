class Form < ActiveRecord::Base
  validates :form_title, presence: true

  scope :descending_update_time, -> { order(updated_at: :desc) }
end

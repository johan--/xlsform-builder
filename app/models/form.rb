class Form < FormBuilder::Model
  has_many :fields

  validates :form_title, presence: true

  scope :descending_update_time, -> { order(updated_at: :desc) }

  TITLE_COLUMNS = 5
end

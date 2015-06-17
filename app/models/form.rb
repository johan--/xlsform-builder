class Form < FormBuilder::Model
  belongs_to :user
  has_many :fields, autosave: true

  validates :form_title, presence: true

  scope :of_user, ->(user) { where(user: user) }
  scope :descending_update_time, -> { order(updated_at: :desc) }

  TITLE_COLUMNS = 5

  def fields_by_index
    fields.order(:index)
  end
end

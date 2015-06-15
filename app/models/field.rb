class Field < FormBuilder::Model
  TYPES = Set.new(['note', 'text'])

  belongs_to :form

  validates :name, presence: true
  # Allow blank names to avoid multiple errors.
  validates :name, format: { with: /\A([a-zA-Z]\w{,31})?\z/ }
  validates :name, uniqueness: {
    scope: :form_id,
    message: 'That name is already used in this form'
  }
  validates :odk_type, presence: true
  validates :odk_type, inclusion: {
    # Allow blank types to avoid multiple errors.
    in: TYPES.clone << '',
    message: 'is invalid'
  }
  validates :label, presence: true
end

class Field < ActiveRecord::Base
  ODK_TYPES = Set.new(['note', 'text'])

  belongs_to :form

  validates :name, format: { with: /\A[a-zA-Z]\w{,31}\z/ }
  validates :name, uniqueness: {
    scope: :form_id,
    message: 'That name is already used in this form'
  }
  validates :odk_type, inclusion: {
    in: ODK_TYPES,
    message: 'Type is invalid'
  }
  validates :label, presence: true
end

class Field < FormBuilder::Model
  TYPES = Set.new(['note', 'text'])

  belongs_to :form
  validates :form, presence: true

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

  before_save :init_index
  private def init_index
    self.index = form.fields.size unless index
  end

  before_destroy :move_last

  def head?
    index == 0
  end

  def tail?
    index == form.fields.size - 1
  end

  def previous_field
    if head?
      nil
    else
      Field.where('form_id = ? AND index = ?', form_id, index - 1).first
    end
  end

  def next_fields
    Field.where 'form_id = ? AND index > ?', form_id, index
  end

  def next_field
    if tail?
      nil
    else
      Field.where('form_id = ? AND index = ?', form_id, index + 1).first
    end
  end

  def swap_index(swap)
    Field.transaction do
      t = self.index
      self.index = swap.index
      swap.index = t
      save!
      swap.save!
    end
  end

  def move_up
    return false if head?
    swap_index previous_field
    true
  end

  def move_down
    return false if tail?
    swap_index next_field
    true
  end

  def move_last
    return false if tail?
    Field.transaction do
      next_fields.each do |field|
        field.index -= 1
        field.save!
      end
      self.index = form.fields.size - 1
      save!
    end
    true
  end
end

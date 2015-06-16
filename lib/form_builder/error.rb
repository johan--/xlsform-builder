class FormBuilder::Error
  attr :model, :attribute, :text

  def initialize(model, attribute, text)
    @model = model
    @attribute = attribute
    @text = text
  end

  def to_s
    if text =~ /\A[A-Z]/
      text
    else
      "#{model.human_attribute_name(attribute)} #{text}"
    end
  end
end

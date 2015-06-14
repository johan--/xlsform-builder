class FormBuilder::Error
  attr :attribute
  attr :text

  def initialize(attribute, text)
    @attribute = attribute
    @text = text
  end

  def to_s
    if text =~ /\A[A-Z]/
      text
    else
      "#{attribute.to_s.tr('_', ' ').capitalize} #{text}"
    end
  end
end

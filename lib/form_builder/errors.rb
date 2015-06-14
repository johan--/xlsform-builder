class FormBuilder::Errors
  include Enumerable

  def initialize(errors)
    errors.is_a? ActiveModel::Errors or raise 'invalid errors argument'

    @errors = Set.new
    errors.messages.each_pair do |attrib, messages|
      messages.each do |text|
        @errors.add FormBuilder::Error.new(attrib, text)
      end
    end
  end

  def each
    if block_given?
      @errors.each { |e| yield e }
    else
      @errors.each
    end
  end
end

class FormBuilder::Errors
  include Enumerable

  def initialize(record)
    @errors = Set.new
    record.errors.messages.each_pair do |attrib, messages|
      messages.each do |text|
        @errors << FormBuilder::Error.new(record.class, attrib, text)
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

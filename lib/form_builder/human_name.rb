class FormBuilder::HumanName
  def initialize(capitalized, uncapitalized=nil)
    @cap = capitalized.clone.freeze
    if uncapitalized
      @uncap = uncapitalized.clone
    elsif capitalized =~ /\A([^A-Z]|[A-Z]{2})/
      @uncap = @cap
    else
      @uncap = capitalized.clone
      @uncap[0] = @uncap[0].downcase
    end
    @uncap.freeze
  end

  def to_s
    @uncap
  end

  def capitalize
    @cap
  end
end

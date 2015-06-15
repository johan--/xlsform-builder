class FormBuilder::Model < ActiveRecord::Base
  self.abstract_class = true

  def self.human_name
    unless defined? @human_name
      @human_name = FormBuilder::HumanName.new(self.to_s)
    end
    @human_name
  end
end

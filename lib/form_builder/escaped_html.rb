class FormBuilder::EscapedHTML
  def initialize(object)
    @html = ERB::Util::h(object.to_s)
    @html.gsub! /\r\n|[\n\r]/, '<br />'
    @html = @html.html_safe
  end

  def to_s
    @html
  end
end

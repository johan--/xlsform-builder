class FormBuilder::XLSForm
  private def new_sheet(name)
    @book.create_worksheet name: name
  end

  private def add_settings
    settings = new_sheet('settings')
    settings[0, 0] = 'form_title'
    settings[1, 0] = @form.form_title
  end

  FIELD_ATTRIBUTES = [:odk_type, :name, :label]
  # Map of Field model attributes to survey sheet column headers
  HEADERS = { odk_type: :type }

  private def add_survey
    survey = new_sheet('survey')

    # Column headers
    FIELD_ATTRIBUTES.each do |attrib|
      survey.row(0).push (HEADERS[attrib] || attrib).to_s
    end

    i = 1
    @form.fields_by_index.each do |field|
      FIELD_ATTRIBUTES.each do |attrib|
        survey.row(i).push field[attrib].to_s
      end
      i += 1
    end
  end

  def initialize(form)
    @form = form
    @book = Spreadsheet::Workbook.new
    add_survey
    add_settings
  end

  def write(path)
    @book.write path
  end
end

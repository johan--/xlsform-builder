class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_form, only: [:show, :confirm_delete, :destroy, :download]

  EDITABLE_ATTRIBUTES = [:form_title]

  def new
    @form = Form.new
  end

  def create
    form = Form.new(safe_params)
    form.user = current_user
    if form.save
      redirect_to form
    else
      @form = form
      render 'new'
    end
  end

  def index
    @forms = Form.of_user(current_user).descending_update_time
  end

  def destroy
    @form.destroy
    redirect_to root_path
  end

  private def download_directory
    dirs = ['tmp', 'xlsforms']
    path = dirs.join(File::SEPARATOR)
    unless File.exists?(path)
      dir = ''
      dirs.each do |el|
        dir << "#{el}#{File::SEPARATOR}"
        Dir.mkdir dir unless File.exists?(dir)
      end
    end
    path
  end

  def download
    form = FormBuilder::XLSForm.new(@form)
    rand = SecureRandom.urlsafe_base64(16)
    path = Rails.root.join("#{download_directory}/#{rand}.xls")
    form.write path
    send_file path, type: 'application/vnd.ms-excel'
  end

  private
  def validate_user
    redirect_to root_path if @form.user != current_user
  end

  def set_form
    @form = Form.find(params[:id])
    validate_user
  end

  def safe_params
    params.require(:form).permit(EDITABLE_ATTRIBUTES)
  end
end

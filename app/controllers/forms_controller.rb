class FormsController < ApplicationController
  before_action :set_form, only: [:show, :destroy]

  EDITABLE_ATTRIBUTES = [:form_title]

  private def init_webform(xlsform)
    @form = xlsform
    @attributes = EDITABLE_ATTRIBUTES
  end

  def new
    init_webform Form.new
  end

  def create
    form = Form.new(safe_params)
    if form.save
      redirect_to form
    else
      init_webform form
      render 'new'
    end
  end

  def destroy
    @form.destroy
    redirect_to root_path
  end

  private
  def set_form
    @form = Form.find(params[:id])
  end

  def safe_params
    params.require(:form).permit(EDITABLE_ATTRIBUTES)
  end
end

class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_form, only: [:show, :confirm_delete, :destroy]

  EDITABLE_ATTRIBUTES = [:form_title]

  def new
    @form = Form.new
  end

  def create
    form = Form.new(safe_params)
    if form.save
      redirect_to form
    else
      @form = form
      render 'new'
    end
  end

  def index
    @forms = Form.descending_update_time
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

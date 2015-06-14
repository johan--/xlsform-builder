class FieldsController < ApplicationController
  before_action :set_field, only: [:destroy]

  private def init_webform(field)
    @field = field
    @form = field.form
  end

  def new
    init_webform Field.new(form_param)
  end

  def create
    field = Field.new(safe_params)
    if field.save
      redirect_to field.form
    else
      init_webform field
      render 'new'
    end
  end

  def destroy
    form = @field.form
    @field.destroy
    redirect_to form
  end

  private
  def set_field
    @field = Field.find(params[:id])
  end

  def form_param
    key = :form_id
    {key => params.require(key)}
  end

  def safe_params
    params.require(:field).permit([:name, :odk_type, :label]).merge form_param
  end
end

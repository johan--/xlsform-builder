class FieldsController < ApplicationController
  before_action :set_field,
    only: [:edit, :update, :destroy, :move_up, :move_down]

  def new
    @field = Field.new(form_param)
  end

  def create
    field = Field.new(safe_params.merge(form_param))
    if field.save
      redirect_to field.form
    else
      @field = field
      render 'new'
    end
  end

  def update
    if @field.update(safe_params)
      redirect_to @field.form
    else
      render 'edit'
    end
  end

  def destroy
    form = @field.form
    @field.destroy
    redirect_to form
  end

  def move_up
    @field.move_up
    redirect_to @field.form
  end

  def move_down
    @field.move_down
    redirect_to @field.form
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
    params.require(:field).permit([:name, :odk_type, :label])
  end
end

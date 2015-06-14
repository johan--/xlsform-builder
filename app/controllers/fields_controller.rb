class FieldsController < ApplicationController
  before_action :set_field, only: [:destroy]

  def destroy
    form = @field.form
    @field.destroy
    redirect_to form
  end

  private def set_field
    @field = Field.find(params[:id])
  end
end

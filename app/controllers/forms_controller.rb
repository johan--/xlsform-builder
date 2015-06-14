class FormsController < ApplicationController
  EDITABLE_ATTRIBUTES = [:form_title]

  def show
    @form = Form.find(params[:id])
  end

  # Initialize a form for creating a new XLSForm.
  private def init_form_form(form)
    @form = form
    @attributes = EDITABLE_ATTRIBUTES
  end

  def new
    init_form_form Form.new
  end

  def create
    form = Form.new(safe_params)
    if form.save
      redirect_to form
    else
      init_form_form form
      render 'new'
    end
  end

  private def safe_params
    params.require(:form).permit(EDITABLE_ATTRIBUTES)
  end
end

class WelcomeController < ApplicationController
  def index
    @forms = Form.all
  end
end

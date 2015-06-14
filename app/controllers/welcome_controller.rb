class WelcomeController < ApplicationController
  def index
    @forms = Form.descending_update_time
  end
end

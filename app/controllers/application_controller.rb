class ApplicationController < ActionController::Base

  def home
    redirect_to lists_path

  end
end

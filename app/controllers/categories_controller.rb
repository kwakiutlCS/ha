class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def create
    category = params[:category][:title]

    p category
  end
  
  
end

class StaticPagesController < ApplicationController
  def home
  	@goals = Goal.all
  end
end

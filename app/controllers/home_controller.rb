class HomeController < ApplicationController
	before_action :set_problem, only: [:editor]
  def index
  end

  def editor
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end
end

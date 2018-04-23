class HomeController < ApplicationController
	before_action :set_problem, only: [:editor, :language]
	
  def index
  end

  def editor
    @lang = Language.find_by(id: params[:lid])
    @code = Code.find_by(problem_id: @problem.id, language_id: @lang)
    if @code.nil?
      redirect_to request.referer || root_path, notice: "This language doesn't exist for the selected challange"
    end
  end
  
  def code_request
    @code = params[:code][:content]
    @judgeid = params[:code][:judgeid]
    @input = params[:code][:input]
    @body = HTTP.headers(:accept => "application/json").post("https://api.judge0.com/submissions/?base64_encoded=false&wait=false", :form => {:source_code => @code, :language_id => @judgeid, :stdin => @input}).parse
    @token = @body["token"]
    @comp = HTTP.headers(:accept => "application/json").get("https://api.judge0.com/submissions/" + @token).parse
    if @comp["stderr"].present?
      @error = @comp["stderr"].squish
    else
      @stdout = @comp["stdout"].squish
    end
    
    respond_to do |format|
      format.html      
      format.js
    end
  end

  def language
    @cpp = Code.find_by(problem_id: @problem.id, language_id: 3)
    @ruby = Code.find_by(problem_id: @problem.id, language_id: 2)
    @js = Code.find_by(problem_id: @problem.id, language_id: 1)
  end
  
  def users
    @users = User.all
  end
  
  def change
    @user = User.find(params[:id])
    if @user.admin == 1
      @user.admin = 0
      @state = "Reular user"
    else
      @user.admin = 1
      @state = "Admin"
    end
    @user.save
    
    respond_to do |format|
      format.html      
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end
end

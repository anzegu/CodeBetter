class HomeController < ApplicationController
	before_action :set_problem, only: [:editor]
  def index
  end

  def editor
    @lang = Language.find_by(id: params[:lid])
    @code = Code.find_by(problem_id: @problem.id, language_id: @lang)
    if @code.nil?
      redirect_to request.referer || root_path, notice: "This language doesn't exist for the selected challange"
    end
  end
  
  def strip_hash_values!(hash)
    hash.each do |k, v|
      case v
      when String
        v.strip!
      when Array
        v.each {|av| av.strip!}
      when Hash
        strip_hash_values!(v)
      end
    end
  end
  
  def code_request
    @code = params[:code][:content]
    @judgeid = params[:code][:judgeid]
    @input = params[:code][:input]
    @body = HTTP.headers(:accept => "application/json").post("https://api.judge0.com/submissions/?base64_encoded=false&wait=false", :form => {:source_code => @code, :language_id => @judgeid, :stdin => @input}).parse
    @token = @body["token"]
    @comp = HTTP.headers(:accept => "application/json").get("https://api.judge0.com/submissions/" + @token).parse
    @comp = strip_hash_values!(@comp)
    @stdout = @comp["stdout"]
    @error = @comp["stderr"]
    
    
    respond_to do |format|
      format.html      
      format.js
    end
  end

  def language
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end
end

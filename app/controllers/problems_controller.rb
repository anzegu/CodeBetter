class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  def index_home
    @problems = Problem.all
  end


  # GET /problems/1
  # GET /problems/1.json
  def show
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
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
    @problem = Problem.new(params.require(:problem).permit(:text, :input1))
    @body = HTTP.headers(:accept => "application/json").post("https://api.judge0.com/submissions/?base64_encoded=false&wait=false", :form => {:source_code => @problem.text, :language_id => "38", :stdin => @problem.input1}).parse
    @token = @body["token"]
    @comp = HTTP.headers(:accept => "application/json").get("https://api.judge0.com/submissions/" + @token).parse
    @comp = strip_hash_values!(@comp)
    @stdout = @comp["stdout"]
    @stderr = @comp["stderr"]
    @message = @comp["message"]
    
    
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:name, :text, :input1, :output1, :input2, :output2)
    end
end

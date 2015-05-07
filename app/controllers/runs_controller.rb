class RunsController < ApplicationController
  before_action :set_run, only: [:show]
  before_action :set_run_by_run_id, only: [:rules, :test]

  # GET /runs
  def new
    @run = Run.new
  end

  # GET /runs
  def index
    @runs = Run.all.order('id DESC') #.paginate(page: params[:page], per_page: 10)
  end

  # GET /runs/1
  def show
    @reduct_set = @run.reduct_set.split.each
  end

  # POST /runs
  def create
    @run = ::Run.new(run_params)

    if @run.rules.rindex('},') == @run.rules.rindex('}')
      @run.rules[@run.rules.rindex('},')...(@run.rules.rindex('},') + '},'.length)] = "}"
    end

    if @run.save
      redirect_to @run, notice: 'Run was successfully created.'
    else
      render :new
    end
  end

  # GET /runs/1/rules
  def rules
    @rules_hash = JSON.parse @run.rules
    @reduct_set = @run.reduct_set.split.each
  end

  # GET /runs/1/test
  def test
    @rules_hash = JSON.parse @run.rules
    @reduct_set = @run.reduct_set.split.each
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      begin
        @run = Run.find(params[:id])
      rescue Exception => e
        redirect_to action: 'index', notice: 'This run doesn\'t exist.'
        return
      end
    end

    def set_run_by_run_id
      begin
        @run = Run.find(params[:run_id])
      rescue Exception => e
        redirect_to action: 'index', notice: 'This run doesn\'t exist.'
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(:name, :reduct_set, :rules)
    end
end

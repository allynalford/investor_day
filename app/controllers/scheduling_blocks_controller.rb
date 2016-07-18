class SchedulingBlocksController < ApplicationController
  before_action :set_scheduling_block, only: [:show, :edit, :update, :destroy]

  # GET /scheduling_blocks
  # GET /scheduling_blocks.json
  def index
    @scheduling_blocks = SchedulingBlock.all
  end

  # GET /scheduling_blocks/1
  # GET /scheduling_blocks/1.json
  def show
  end

  # GET /scheduling_blocks/new
  def new
    @scheduling_block = SchedulingBlock.new
  end

  # GET /scheduling_blocks/1/edit
  def edit
  end

  # POST /scheduling_blocks
  # POST /scheduling_blocks.json
  def create
    @scheduling_block = SchedulingBlock.new(scheduling_block_params)

    respond_to do |format|
      if @scheduling_block.save
        format.html { redirect_to @scheduling_block, notice: 'Scheduling block was successfully created.' }
        format.json { render :show, status: :created, location: @scheduling_block }
      else
        format.html { render :new }
        format.json { render json: @scheduling_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scheduling_blocks/1
  # PATCH/PUT /scheduling_blocks/1.json
  def update
    respond_to do |format|
      if @scheduling_block.update(scheduling_block_params)
        format.html { redirect_to @scheduling_block, notice: 'Scheduling block was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduling_block }
      else
        format.html { render :edit }
        format.json { render json: @scheduling_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduling_blocks/1
  # DELETE /scheduling_blocks/1.json
  def destroy
    @scheduling_block.destroy
    respond_to do |format|
      format.html { redirect_to scheduling_blocks_url, notice: 'Scheduling block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduling_block
      @scheduling_block = SchedulingBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheduling_block_params
      params.require(:scheduling_block).permit(:start_time, :bookable)
    end
end

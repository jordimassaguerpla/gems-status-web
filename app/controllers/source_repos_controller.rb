class SourceReposController < ApplicationController
  before_action :set_source_repo, only: [:show, :edit, :update, :destroy]

  # GET /source_repos
  # GET /source_repos.json
  def index
    @source_repos = SourceRepo.all
  end

  # GET /source_repos/1
  # GET /source_repos/1.json
  def show
  end

  # GET /source_repos/new
  def new
    @source_repo = SourceRepo.new
  end

  # GET /source_repos/1/edit
  def edit
  end

  # POST /source_repos
  # POST /source_repos.json
  def create
    @source_repo = SourceRepo.new(source_repo_params)

    respond_to do |format|
      if @source_repo.save
        format.html { redirect_to @source_repo, notice: 'Source repo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @source_repo }
      else
        format.html { render action: 'new' }
        format.json { render json: @source_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_repos/1
  # PATCH/PUT /source_repos/1.json
  def update
    respond_to do |format|
      if @source_repo.update(source_repo_params)
        format.html { redirect_to @source_repo, notice: 'Source repo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @source_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_repos/1
  # DELETE /source_repos/1.json
  def destroy
    @source_repo.destroy
    respond_to do |format|
      format.html { redirect_to source_repos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_repo
      @source_repo = SourceRepo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_repo_params
      params.require(:source_repo).permit(:name, :url)
    end
end

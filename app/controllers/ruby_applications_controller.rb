class RubyApplicationsController < ApplicationController
  before_action :set_ruby_application, only: [:show]

  # GET /ruby_applications/1
  # GET /ruby_applications/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ruby_application
      @ruby_application = RubyApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ruby_application_params
      params.require(:ruby_application).permit(:name, :filename, :gems_url)
    end
end

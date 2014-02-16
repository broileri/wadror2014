class StylesController < ApplicationController
	before_action :set_style, only: [:show, :edit, :update, :destroy]

	def index
		@styles = Style.all
	end

	def show
	end

	def edit
	end

	def new
      @style = Style.new
    end

    def create
      @style = Style.new(style_params)

      respond_to do |format|
        if @style.save
          format.html { redirect_to styles_path, notice: 'Style was successfully created.' }
          format.json { render action: 'show', status: :created, location: @style }
        else
          format.html { render action: 'new' }
          format.json { render json: @style.errors, status: :unprocessable_entity }
        end
      end    
    end

	def update
      respond_to do |format|
        if @style.update(style_params)
          format.html { redirect_to @style, notice: 'Style was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @style.errors, status: :unprocessable_entity }
        end
      end
    end

	def destroy
	  if @style.beers.length == 0	
        @style.destroy 
        respond_to do |format|
          format.html { redirect_to styles_url }
          format.json { head :no_content }
        end
      else
      	respond_to do |format|
          format.html { redirect_to @style, notice: 'Style cannot be deleted, because it is still used by some beer(s).' }
          format.json { head :no_content }
        end
      end
   end

	private
      # Use callbacks to share common setup or constraints between actions.
      def set_style
        @style = Style.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def style_params
        params.require(:style).permit(:name, :description)
      end
end
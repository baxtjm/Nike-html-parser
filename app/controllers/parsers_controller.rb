class ParsersController < ApplicationController
  before_action :set_parser, only: [:show, :edit, :update, :destroy]

  # GET /parsers
  # GET /parsers.json
  def index
    @parsers = Parser.all
  end

  # GET /parsers/1
  # GET /parsers/1.json
  def show
        url = "https://miami.craigslist.org/search/mdc/sub"

        response = HTTParty.get url

        # puts response.headers['content-type']
        #
        # puts response.body

        @dom = Nokogiri::HTML(response.body)

        @dom.css("a.hdrlnk").map do |element|
            element.content
    end
  end

  # GET /parsers/new
  def new
    @parser = Parser.new
  end

  # GET /parsers/1/edit
  def edit
  end

  # POST /parsers
  # POST /parsers.json
  def create
    @parser = Parser.new(parser_params)

    respond_to do |format|
      if @parser.save
        format.html { redirect_to @parser, notice: 'Parser was successfully created.' }
        format.json { render :show, status: :created, location: @parser }
      else
        format.html { render :new }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parsers/1
  # PATCH/PUT /parsers/1.json
  def update
    respond_to do |format|
      if @parser.update(parser_params)
        format.html { redirect_to @parser, notice: 'Parser was successfully updated.' }
        format.json { render :show, status: :ok, location: @parser }
      else
        format.html { render :edit }
        format.json { render json: @parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parsers/1
  # DELETE /parsers/1.json
  def destroy
    @parser.destroy
    respond_to do |format|
      format.html { redirect_to parsers_url, notice: 'Parser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parser
      @parser = Parser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parser_params
      params.fetch(:parser, {})
    end
end

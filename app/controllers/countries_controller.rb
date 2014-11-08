class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 50
    token = params[:token]
    @countries = Country
      .where("countries.name LIKE :token OR countries.code LIKE :token", {token: "%#{token}%"})
      .joins("left join visits on visits.country_id = countries.code AND visits.user_id = #{current_user.id}")
      .group('countries.code')
      .select('name, code, COUNT(visits.user_id) as visited_count')
      .paginate(page: page, per_page: per_page)

    respond_to do |format|
      format.html {  render 'home/index' }
      format.xml  { render :xml => @countries }

      format.json { render json: @countries.as_json({methods: [:visited], only: [ :name, :code]}) }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

end
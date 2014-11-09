class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    page      = params[:page] || 1
    per_page  = params[:per_page] || 50
    token     = params[:q]
    @countries = Country.where("name LIKE :token OR code LIKE :token", {token: "%#{token}%"})
    .visited_info_for(current_user)
    .paginate(page: page, per_page: per_page)

    respond_to do |format|
      format.html { render 'home/index' }
      format.xml { render :xml => countries }
      format.json {
        render json: {
          countries:  @countries.as_json({methods: [:visited], only: [:name, :code]}),
          pagination: {
            current_page:  @countries.current_page,
            total_pages:   @countries.total_pages,
            total_entries: @countries.total_entries
          }
        }
      }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  def counts
    @counts = {visited: current_user.visited_countries_count,
               unvisited: current_user.not_visited_countries_count}
    render json: @counts
  end

  def chart_data
    @chart_data = current_user.visits.group('DATE(created_at)').select('count(*) as count, DATE(created_at) as date').map do |visit|
      [Date.parse(visit.date).to_time.to_i * 1000, visit.count]
    end
    render json: @chart_data
  end

end
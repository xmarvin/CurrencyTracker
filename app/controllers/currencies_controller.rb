class CurrenciesController < ApplicationController
  # GET /currencies
  # GET /currencies.xml
  
  def index
    page      = params[:page] || 1
    per_page  = params[:per_page] || 50
    token     = params[:q]
    @currencies = Currency.includes(:country).where("name LIKE :token OR code LIKE :token", {token: "%#{token}%"})
    .collected_info_for(current_user)
    .paginate(page: page, per_page: per_page)

    respond_to do |format|
      format.html { render 'home/index' }
      format.xml { render :xml => currencies }
      format.json {
        render json: {
          currencies:  @currencies.as_json({methods: [:collected, :country_name], only: [:name, :code, :country_id]}),
          pagination: {
            current_page:  @currencies.current_page,
            total_pages:   @currencies.total_pages,
            total_entries: @currencies.total_entries
          }
        }
      }
    end
  end

  def counts
    @counts = {collected: current_user.collected_currencies_count,
               uncollected: current_user.not_collected_currencies_count}
    render json: @counts
  end

  def chart_data
    @chart_data = current_user.visits.group('DATE(visits.created_at)').joins(:currencies).select('count(currencies.code) as count, DATE(visits.created_at) as date').map do |visit|
      [Date.parse(visit.date).to_time.to_i * 1000, visit.count]
    end
    render json: @chart_data
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end
end
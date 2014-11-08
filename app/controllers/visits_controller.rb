class VisitsController < ApplicationController
  def bulk_update
    bulk = params[:bulk]
    if bulk
      codes_to_add = bulk.select{|a| a[:checked]}.map{|a| { country_id: a[:code] } }.uniq
      codes_to_remove = bulk.reject{|a| a[:checked]}.map{|a| a[:code]}.uniq
      Visit.transaction do
        current_user.visits.where(country_id: codes_to_remove).delete_all
        current_user.visits.create! codes_to_add
      end
    end
    render nothing: true
  end

  def counts
    render json: {visited: current_user.visited_countries_count,
                  unvisited: current_user.not_visited_countries_count}
  end

end
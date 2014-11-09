class VisitsController < ApplicationController
  def bulk_update
    bulk = params[:bulk]
    if bulk
      codes_to_add = bulk.select{|a| a[:checked]}.map{|a| { country_id: a[:code] } }.uniq
      codes_to_remove = bulk.reject{|a| a[:checked]}.map{|a| a[:code]}.uniq
      Visit.transaction do
        current_user.visits.where(country_id: codes_to_remove).delete_all unless codes_to_remove.blank?
        current_user.visits.create! codes_to_add  unless codes_to_add.blank?
      end
    end
    render nothing: true
  end

end
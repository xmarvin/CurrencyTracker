class Currency < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  belongs_to :country

  def self.collected
    @collected ||= Currency.joins(:country).where(countries: { visited: true})
  end

  def self.not_collected
    @not_collected ||= Currency.joins(:country).where(countries: { visited: false})
  end

  def collected?
    country.nil? ? false : country.visited?
  end
end

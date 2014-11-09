class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :visits

  def visited_countries_count
    @visited_countries_count ||= visits.count
  end

  def not_visited_countries_count
    @not_visited_countries_count ||= Country.count - visited_countries_count
  end

  def collected_currencies_count
    @collected_currencies_count ||= visits.joins(:currencies).count
  end

  def not_collected_currencies_count
    @not_collected_currencies_count ||= Currency.count - collected_currencies_count
  end

  def visited?(country)
    visits.where(country_id: country.id).exists?
  end

end

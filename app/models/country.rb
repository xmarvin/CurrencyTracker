class Country < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  has_many :currencies
  has_many :visits

  accepts_nested_attributes_for :currencies, :allow_destroy => true

  scope :visited_info_for,  lambda { |user|
    joins("left join visits on visits.country_id = countries.code AND visits.user_id = #{user.id}")
    .group('countries.code')
    .select('name, code, COUNT(visits.user_id) as visited_count')
  }

  def visited_by?(user)
    visits.where(user_id: user.id).exists?
  end

  def visited
    read_attribute(:visited_count ).to_i > 0
  end

end

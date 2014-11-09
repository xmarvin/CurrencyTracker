class Currency < ActiveRecord::Base
  self.primary_key = :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  belongs_to :country
  has_many :visits, foreign_key: :country_id

  scope :collected_info_for,  lambda { |user|
    joins("left join visits on visits.country_id = currencies.country_id AND visits.user_id = #{user.id}")
    .group('currencies.code')
    .select('name, code, COUNT(visits.user_id) as collected_count')
  }

  def collected_by?(user)
    visits.where(user_id: user.id).exists?
  end

  def collected
    read_attribute(:visited_count ).to_i > 0
  end

end

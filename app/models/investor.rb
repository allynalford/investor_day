# == Schema Information
#
# Table name: investors
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Investor < ActiveRecord::Base
  has_many :rankings, as: :ranker
  has_many :matches

  scope :unmatched, -> (time_slot) do 
    # an unmatched investor is one that
    # does not have at least the number of matches as they do rankings
    joins(
      [
        "LEFT OUTER JOIN matches ON investors.id = matches.investor_id",
        " LEFT OUTER JOIN rankings ON investors.id = rankings.ranker_id AND rankings.ranker_type = 'Investor'" 
      ].join
    ).having(
      'COUNT(matches.id) < COUNT(rankings.id)'
    ).group("investors.id")
  end
end

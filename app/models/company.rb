# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  has_many :rankings, as: :ranker
  has_many :matches
  scope :unmatched, -> (time_slot) do 
    # an unmatched company is one that
    # does not have at least the number of matches as they do rankings
    joins(
      [
        "LEFT OUTER JOIN matches ON companies.id = matches.company_id AND matches.scheduling_block_id = #{time_slot.id}",
        " LEFT OUTER JOIN rankings ON companies.id = rankings.ranker_id AND rankings.ranker_type = 'Company'" 
      ].join
    ).having(
      'COUNT(matches.id) < COUNT(rankings.id)'
    ).group("companies.id")
  end

  def free?(time_slot)
    # returns true 
    # if this company has no investor match for the time_slot
    !matches.exists?(scheduling_block: time_slot)
  end

  def has_hard_match?(investor, time_slot)
    # returns false
    # if there is no existing match for this company/investor
    # prior to the provided time_slot
    all_blocks = SchedulingBlock.where(
      bookable: true
    ).order(start_time: :asc).pluck(:id)
    starting_slot = all_blocks.index(time_slot.id)

    matches.exists?(
      investor: investor,
      scheduling_block: all_blocks[0..starting_slot]
    )
  end

  def prefers?(investor, current_investor)
    co_rankings = rankings.ordered.map(&:rankee)
    x = co_rankings.index(investor) 
    y = co_rankings.index(current_investor) 
    if x && y
      x < y 
    elsif x && !y
      x
    elsif !x && y
      y
    end 
  end

  def current_match(time_slot)
    # should return a match 
    matches.find_by(scheduling_block: time_slot)
  end
end

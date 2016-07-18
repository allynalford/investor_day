# == Schema Information
#
# Table name: matches
#
#  id                  :integer          not null, primary key
#  scheduling_block_id :integer
#  company_id          :integer
#  investor_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ranking_id          :integer
#
# Indexes
#
#  index_matches_on_company_id           (company_id)
#  index_matches_on_investor_id          (investor_id)
#  index_matches_on_ranking_id           (ranking_id)
#  index_matches_on_scheduling_block_id  (scheduling_block_id)
#

class Match < ActiveRecord::Base
  belongs_to :scheduling_block
  belongs_to :company
  belongs_to :investor
  belongs_to :ranking

  def self.schedule
    all.order("rankings.score DESC").joins(:ranking).map do |m|
      "#{m.investor.name} meets with #{m.company.name} at #{m.scheduling_block.start_time}"
    end
  end
end

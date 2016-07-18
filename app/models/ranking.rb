# == Schema Information
#
# Table name: rankings
#
#  id          :integer          not null, primary key
#  rankee_id   :integer
#  rankee_type :string
#  ranker_id   :integer
#  ranker_type :string
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_rankings_on_rankee_type_and_rankee_id  (rankee_type,rankee_id)
#  index_rankings_on_ranker_type_and_ranker_id  (ranker_type,ranker_id)
#

class Ranking < ActiveRecord::Base
  belongs_to :rankee, polymorphic: true
  belongs_to :ranker, polymorphic: true

  scope :ordered, -> { order(score: :desc) }

  def self.generate_matches
    investors = Investor.all
    investors.each do |inv|
      # 3, 1 & 2
      matches = inv.rankings.ordered.map do |ranking|
        co = ranking.rankee
        index = co.rankings.ordered.map(&:rankee).index(inv)

        inv.matches.build(
          company: co, 
          ranking: co.rankings.ordered[index]
        ) if index # 2a
      end

      matches.sort_by{|m| m.ranking.score }.reverse.each do |m|
        m.scheduling_block = SchedulingBlock.available(
          m.investor,
          m.company
        ).try(:first)
        m.save
      end
    end
  end
end

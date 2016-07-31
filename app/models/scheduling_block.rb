# == Schema Information
#
# Table name: scheduling_blocks
#
#  id         :integer          not null, primary key
#  start_time :string
#  bookable   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SchedulingBlock < ActiveRecord::Base
  has_many :matches

  # we want the first available scheduling block or nil
  scope :available, -> (investor, company) do 
    inv_blocks = investor.matches.pluck(:scheduling_block_id)
    co_blocks = company.matches.pluck(:scheduling_block_id)

    where(bookable: true).where.not(
      id: (inv_blocks+co_blocks)
    ).order(start_time: :asc)
  end

  # other potential solution 
  # (shapley algo on each block create hard match from sets after each iteration)
  # :)
  def generate_match

    # sequoia: UP 10, Z 9, HM 7
    # greylock: IILWY 10, Z 10, HM 8
    # crunchf: 43L 10, UP 8, HM 5
    # 43L: C 9
    # UP: CF 10, S 8
    # IILWY: G 8
    # HM: C 10, G 9, S 8
    # Z: S 10, G 7

    # sequoia & UP
    # greylock & IILWY
    # crunchf & 43L

    # sequoia & Z (unmatch sequoia & UP)
    # greylock & Z (greylock & IILWY stay matched)
    # crunchf & UP (unmatch crunchf & 43L)

    # sequoia & HM (sequoia & Z stay matched)
    # greylock & HM (greylock & HM matched)
    # crunchf & HM (unmatch greylock & HM)

    # final results
    # S & Z
    # C & HM
    # G & I

    # 10am slot filled

    # sequoia: UP 10, Z 9, HM 7
    # greylock: IILWY 10, Z 10, HM 8
    # crunchf: 43L 10, UP 8, HM 5
    # 43L: C 9
    # UP: CF 10, S 8
    # IILWY: G 8
    # HM: C 10, G 9, S 8
    # Z: S 10, G 7

    # sequoia & UP
    # greylock & IILWYU (hard match, greylock stays unmatched)
    # crunchf & 43L

    # sequoia & Z (hard match, sequoia & UP stay matched)
    # greylock & Z 
    # crunchf & UP (unmatch crunchf & 43L)

    # sequoia & HM (equal match, sequoia & UP stay matched)
    # greylock & HM (greylock & HM matched)
    # crunchf & HM (unmatch greylock & HM)

    # final results
    # S & U
    # G & Z
    # C & HM

    # 10:20am slot filled

    # sequoia: UP 10, Z 9, HM 7
    # greylock: IILWY 10, Z 10, HM 8
    # crunchf: 43L 10, UP 8, HM 5
    # 43L: C 9
    # UP: CF 10, S 8
    # IILWY: G 8
    # HM: C 10, G 9, S 8
    # Z: S 10, G 7

    # sequoia & UP (hard match, sequoia stays unmatched)
    # greylock & IILWYU (hard match, greylock stays unmatched)
    # crunchf & 43L

    # sequoia & Z (hard match, sequoia stays unmatched)
    # greylock & Z (hard match, greylock stays unmatched)
    # crunchf & UP (unmatch crunchf & 43L)

    free_investors = Investor.unmatched(self)
    free_companies = Company.unmatched(self)

    while free_investors.to_a.size > 0 && free_companies.to_a.size > 0
      investor = free_investors.first
      byebug
      company_ranking = investor.rankings.ordered.unmatched(investor).first
      company = company_ranking.rankee

      
      if company.free?(self)
        if !company.has_hard_match?(investor, self)
          match = investor.matches.create(
            scheduling_block: self,
            company: company,
            ranking: company_ranking
          )
        end
      else
        free_investors = Investor.unmatched(self)
        if company.prefers?(investor, company.current_match(self).investor)
          company.current_match(self).destroy
          match = investor.matches.create(
            scheduling_block: self,
            company: company,
            ranking: company_ranking
          )
        else
          free_investors = Investor.unmatched(self).where.not(id: investor.id)
        end
      end
      free_companies = Company.unmatched(self)
    end
  end
end

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
end

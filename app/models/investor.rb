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
end

# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  description       :string
#  expected_delivery :datetime
#  receiving_address :string
#  sending_address   :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Order < ApplicationRecord
  def self.incoming
    Order.where(receiving_address: Location.pluck(:address))
  end

  def self.outgoing
    Order.where(sending_address: Location.pluck(:address))
  end
end

#/workspaces/Inventory-Management-System/app/models/order.rb
# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  description       :string
#  expected_delivery :date
#  receiving_address :string
#  sending_address   :string
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  def self.incoming
    Order.where(receiving_address: StorageLocation.pluck(:address)).order(expected_delivery: :asc)
  end

  def self.outgoing
    Order.where(sending_address: StorageLocation.pluck(:address)).order(expected_delivery: :asc)
  end
  include Ransackable
  
end

# == Schema Information
#
# Table name: debts
#
#  id         :integer          not null, primary key
#  amount     :decimal(, )
#  comment    :text
#  owner_id   :integer
#  payer_id   :integer
#  start_date :date
#  due_date   :date
#  paid_date  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paid       :boolean          default(FALSE)
#

class Debt < ActiveRecord::Base

  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :payer, :class_name => 'User', :foreign_key => 'payer_id'


  scope :unpaid, -> { where(:paid => false) }

end

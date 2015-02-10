require 'state_machine/core'
class Order < ActiveRecord::Base
extend StateMachine::MacroMethods

  
  has_many :item_lines
  validates_numericality_of :vat, :message => 'is not a number'
  belongs_to :user, :class => "Order", :foreign_key => "user_id"
  has_one :status_transition
  accepts_nested_attributes_for :item_lines, :status_transition
  after_create :create_status
  #after_save :update_status_transition
  
  def create_status
    self.create_status_transition if self.status_transition.nil?
  end
  
    state_machine :state, :initial => :draft do
    state :draft, value: 0
    state :placed, value: 1
    state :paid, value: 2
    state :canceled, value: 3
    

    after_transition any => any do |order, transition|
     p order # disavle this as needed
     order.status_transition.update(event: transition.event, from: transition.from_name, to: transition.to_name)
   end


    event :place do 
      transition :draft => :placed
    end
    event :cancel do
        transition :draft => :canceled
        transition :placed => :canceled
    end
    event :pay do 
      transition :placed => :paid
    end
    
    end
    
    private
   def update_status_transition
    case self.state 
    when 0 
      puts "created"
    when 1       
      self.place
    when 2
      self.pay
    when 3
      self.cancel
    end
  end
end

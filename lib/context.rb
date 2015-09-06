class GitHub::Context
  attr_accessor :event, :payload, :rules_matched, :actions_taken
  
  def initialize
    self.rules_matched = 0
    self.actions_taken = 0
  end

  def get_binding
    binding
  end  
end

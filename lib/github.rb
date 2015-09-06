module GitHub
  @rules_block
  @rules = []

  def self.rule(&block)
    @rules << Rule.new(&block)
  end
  
  def self.rules(&block)
    @rules_block = block
  end
  
  def self.evaluate
    instance_eval &@rules_block
  end
  
  # @param [GitHub::Context] context
  def self.execute(context)
    @rules.each do |rule|
      begin
        rule.execute context
      rescue Exception => e
        p e.backtrace
      end
    end
  end
  
  def self.reset
    @rules = []
  end
end

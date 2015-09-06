module GitHub::Plugin
  @registry = {}
  
  def self.register(type, name, klass)
    @registry[type] = {} if @registry[type].nil?
    @registry[type][name] = klass
  end

  def self.filter(what, params)
    raise "Unknown filter #{what}" unless @registry[:filter].has_key? what
    @registry[:filter][what].new(params)
  end

  def self.action(what, params)
    raise "Unknown action #{what}" unless @registry[:action].has_key? what
    @registry[:action][what].new(params)
  end
end

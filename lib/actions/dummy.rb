class GitHub::Plugin::Dummy
  GitHub::Plugin.register :action, :dummy, self
  
  def initialize(params)
    @message = params[0]
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def execute(context)
    p context
  end
end

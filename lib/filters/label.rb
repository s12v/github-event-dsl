class GitHub::Plugin::Label
  GitHub::Plugin.register :filter, :label, self

  def initialize(params)
    @label = params[0]
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def match(context)
    return false unless context.event == 'pull_request'
    return false unless context.payload['action'] == 'labeled'
    return false if context.payload['label'].nil?
    
    label = context.payload['label']['name']
    if @label.is_a?(Regexp)
      @label === label
    elsif @label.is_a?(Array)
      @label.include? label
    else
      @label == label
    end
  end
end

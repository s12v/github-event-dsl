class GitHub::Plugin::Release
  GitHub::Plugin.register :filter, :release, self

  def initialize(params)
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def match(context)
    return false unless context.event == 'release'
    return false unless context.payload['action'] == 'published'
    return false if context.payload['release'].nil?
    return false if context.payload['release']['name'].nil?
    return false if context.payload['release']['draft']
    return false if context.payload['release']['prerelease']
    
    true
  end
end

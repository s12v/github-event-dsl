class GitHub::Plugin::Repo
  GitHub::Plugin.register :filter, :repo, self

  def initialize(params)
    @repo = params[0]
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def match(context)
    return false if context.payload['repository'].nil?

    repo = context.payload['repository']['full_name']
    if @repo.is_a?(Regexp)
      @repo === repo
    elsif @repo.is_a?(Array)
      @repo.include? repo
    else
      @repo == repo
    end
  end
end

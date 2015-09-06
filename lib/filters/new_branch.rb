class GitHub::Plugin::NewBranch
  GitHub::Plugin.register :filter, :new_branch, self

  def initialize(params)
    @branch = params[0]
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def match(context)
    return false
  end
end

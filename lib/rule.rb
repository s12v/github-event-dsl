class GitHub::Rule
  def initialize(&block)
    @filters = []
    @not_filters = []
    @actions = []
    instance_eval &block
  end

  def on(what, *params)
    @filters << GitHub::Plugin.filter(what, params)
  end

  def except(what, *params)
    @not_filters << GitHub::Plugin.filter(what, params)
  end

  def action(what, *params)
    @actions << GitHub::Plugin.action(what, params)
  end

  # @param [GitHub::Context] context
  def execute(context)
    if match context
      @actions.each do |action|
        action.execute context
        context.actions_taken += 1
      end
      context.rules_matched += 1
    end
  end

  private

  # @param [GitHub::Context] context
  # @return [Boolean]
  def match(context)
    match_all(@filters, context) && !match_any(@not_filters, context)
  end

  # @param [Array] filters
  # @param [GitHub::Context] context
  # @return [Boolean]
  def match_all(filters, context)
    filters.inject(true) { |r, filter| r && filter.match(context) }
  end

  # @param [Array] filters
  # @param [GitHub::Context] context
  # @return [Boolean]
  def match_any(filters, context)
    filters.inject(false) { |r, filter| r || filter.match(context) }
  end
end

require 'erb'
require 'slack-poster'

class GitHub::Plugin::Slack
  GitHub::Plugin.register :action, :slack, self
  attr_accessor :poster, :template
  
  def initialize(params)
    url = ENV['SLACK_URL'] || ''
    options = {
      username: 'GitBot',
      channel: params[0][:to],
      icon_url: 'https://slack.global.ssl.fastly.net/5721/plugins/github/assets/bot_48.png'
    }
    @template = GitHub::Template.load(params[0][:template])
    self.poster = Slack::Poster.new(url, options)
  end

  # @param [GitHub::Context] context
  # @return [Boolean]
  def execute(context)
    message = ERB.new(@template).result context.get_binding
    poster.send_message message
  end

end

require 'sinatra/base'
require 'lib/github'
require 'lib/context'
require 'lib/plugin'
require 'lib/rule'
require 'lib/template'
require 'lib/actions/dummy'
require 'lib/actions/slack'
require 'lib/filters/label'
require 'lib/filters/new_branch'
require 'lib/filters/release'
require 'lib/filters/repo'
require 'rules'

class GitBot < Sinatra::Application
  
  configure do
    set :github_secret, ENV['GITHUB_SECRET'] || ''
    GitHub::Template.path = settings.views
    GitHub.evaluate
  end
  
  helpers do
    def valid_signature(payload)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), settings.github_secret, payload)
      signature.eql? request.env['HTTP_X_HUB_SIGNATURE']
    end
  end
  
  get '/ping' do
    'pong'
  end
  
  post '/github' do
    halt 400, 'No github event' if request.env['HTTP_X_GITHUB_EVENT'].nil?
    
    payload = request.body.read
    halt 401, 'Invalid signature' unless valid_signature(payload) 
    
    begin
      context = GitHub::Context.new
      context.event = request.env['HTTP_X_GITHUB_EVENT']
      context.payload = JSON.parse(payload)
      GitHub.execute context
      halt 200, "Matched #{context.rules_matched} rules, #{context.actions_taken} actions"
    rescue JSON::ParserError
      halt 400, 'Invalid payload'
    end
  end
end

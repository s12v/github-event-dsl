require_relative '../test_helper.rb'

describe GitHub::Plugin::Slack do
  before do
    @params = [{channel: 'foo', template: 'bar'}]
  end

  it 'must respond to execute' do
    GitHub::Template.stub :load, 'test' do
      slack = GitHub::Plugin::Slack.new @params
      slack.must_respond_to :execute
    end
  end

  it 'must register itself as an action' do
    GitHub::Template.stub :load, 'test' do
      object = GitHub::Plugin.action(:slack, @params)
      object.must_be_instance_of GitHub::Plugin::Slack
    end
  end
  
  it 'must send a message' do
    GitHub::Template.stub :load, 'test' do
      mock = MiniTest::Mock.new
      mock.expect(:send_message, true, [String])
      
      slack = GitHub::Plugin::Slack.new @params
      slack.poster = mock
      context = GitHub::Context.new
      context.payload = {
        'repository' => {
          'full_name' => 'foo/bar',
        }
      }
  
      slack.execute context
      mock.verify
    end
  end
end

require_relative '../test_helper.rb'

describe GitHub::Plugin::Label do
  it 'must respond to match' do
    label = GitHub::Plugin::Label.new ['foo']
    label.must_respond_to :match
  end

  it 'must register itself as a filter' do
    object = GitHub::Plugin.filter(:label, [])
    object.must_be_instance_of GitHub::Plugin::Label
  end

  it 'must match string' do
    context = GitHub::Context.new
    context.event = 'pull_request'
    context.payload = {
      'action' => 'labeled',
      'label' => {
        'name' => 'foo',
      }
    }
    label = GitHub::Plugin::Label.new ['foo']
    label.match(context).must_be_same_as true
  end

  it 'must match array' do
    context = GitHub::Context.new
    context.event = 'pull_request'
    context.payload = {
      'action' => 'labeled',
      'label' => {
        'name' => 'foo',
      }
    }
    label = GitHub::Plugin::Label.new [%w(foo bar)]
    label.match(context).must_be_same_as true
  end

  it 'must match regexp' do
    context = GitHub::Context.new
    context.event = 'pull_request'
    context.payload = {
      'action' => 'labeled',
      'label' => {
        'name' => 'foo bar',
      }
    }
    label = GitHub::Plugin::Label.new [%r(foo)]
    label.match(context).must_be_same_as true
  end

  it 'must not match push' do
    context = GitHub::Context.new
    context.event = 'push'
    context.payload = {}

    release = GitHub::Plugin::Release.new []
    release.match(context).must_be_same_as false
  end
  
end

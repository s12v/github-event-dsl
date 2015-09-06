require_relative '../test_helper.rb'

describe GitHub::Plugin::Dummy do
  it 'must respond to execute' do
    dummy = GitHub::Plugin::Dummy.new ['foo']
    dummy.must_respond_to :execute
  end

  it 'must register itself as an action' do
    object = GitHub::Plugin.action(:dummy, [])
    object.must_be_instance_of GitHub::Plugin::Dummy
  end
end

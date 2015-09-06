require_relative '../test_helper.rb'

describe GitHub::Plugin::NewBranch do
  it 'must respond to match' do
    release = GitHub::Plugin::NewBranch.new ['foo']
    release.must_respond_to :match
  end

  it 'must register itself as a filter' do
    object = GitHub::Plugin.filter(:new_branch, ['foo'])
    object.must_be_instance_of GitHub::Plugin::NewBranch
  end

end

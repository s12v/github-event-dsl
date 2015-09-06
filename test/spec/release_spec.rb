require_relative '../test_helper.rb'

describe GitHub::Plugin::Release do
  it 'must respond to match' do
    release = GitHub::Plugin::Release.new []
    release.must_respond_to :match
  end

  it 'must register itself as a filter' do
    object = GitHub::Plugin.filter(:release, [])
    object.must_be_instance_of GitHub::Plugin::Release
  end

  it 'must match' do
    context = GitHub::Context.new
    context.event = 'release'
    context.payload = {
      'action' => 'published',
      'release' => {
        'name' => 'Release 0.1',
        'prerelease' => false,
      }
    }
    
    release = GitHub::Plugin::Release.new []
    release.match(context).must_be_same_as true
  end

  it 'must not match draft' do
    context = GitHub::Context.new
    context.event = 'release'
    context.payload = {
      'action' => 'published',
      'release' => {
        'name' => 'Release 0.1',
        'prerelease' => true,
      }
    }
    
    release = GitHub::Plugin::Release.new []
    release.match(context).must_be_same_as false
  end

  it 'must not match prerelease' do
    context = GitHub::Context.new
    context.event = 'release'
    context.payload = {
      'action' => 'published',
      'release' => {
        'name' => 'Release 0.1',
        'prerelease' => true,
      }
    }
    
    release = GitHub::Plugin::Release.new []
    release.match(context).must_be_same_as false
  end

  it 'must not match push' do
    context = GitHub::Context.new
    context.event = 'push'
    context.payload = {}
    
    release = GitHub::Plugin::Release.new []
    release.match(context).must_be_same_as false
  end
  
end

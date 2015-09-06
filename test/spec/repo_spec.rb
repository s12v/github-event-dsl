require_relative '../test_helper.rb'

describe GitHub::Plugin::Repo do
  it 'must respond to match' do
    repo = GitHub::Plugin::Repo.new ['foo/bar']
    repo.must_respond_to :match
  end

  it 'must register itself as a filter' do
    object = GitHub::Plugin.filter(:repo, [])
    object.must_be_instance_of GitHub::Plugin::Repo
  end

  it 'must match string' do
    repo = GitHub::Plugin::Repo.new ['foo/bar']
    context = GitHub::Context.new
    context.payload = {
      'repository' => {
        'full_name' => 'foo/bar',
      }
    }
    repo.match(context).must_be_same_as true
  end

  it 'must match array' do
    repo = GitHub::Plugin::Repo.new [%w(foo/bar aaa/bbb)]
    context = GitHub::Context.new
    context.payload = {
      'repository' => {
        'full_name' => 'aaa/bbb',
      }
    }
    repo.match(context).must_be_same_as true
  end

  it 'must match regexp' do
    repo = GitHub::Plugin::Repo.new [%r(foo)]
    context = GitHub::Context.new
    context.payload = {
      'repository' => {
        'full_name' => 'foo/bar',
      }
    }
    repo.match(context).must_be_same_as true
  end
end

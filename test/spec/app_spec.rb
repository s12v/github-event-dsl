require_relative '../test_helper.rb'

include Rack::Test::Methods

def app
  GitBot
end

describe GitBot do
  it 'should respond to ping' do
    get '/ping'
    last_response.body.must_include 'pong'
  end
  
  it 'should return error 400 on invalid request' do
    post '/github'
    assert last_response.bad_request?
    last_response.body.must_include 'No github event'
  end
  
  it 'should return error on invalid signature' do
    header 'X-GitHub-Event', 'pull_request'
    header 'X-Hub-Signature', 'invalid'
    post '/github', '{"a":"b"}'
    assert !last_response.ok?
  end
  
  it 'should proceed on valid signature' do
    GitHub.reset
    GitHub.stub :execute, nil do
      header 'X-GitHub-Event', 'pull_request'
      header 'X-Hub-Signature', 'sha1=ceb9e174dc7aa677f67f97df063a30a057794726'
      post '/github', '{"a":"b"}'
      assert last_response.ok?
    end
  end
end

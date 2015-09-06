$:.unshift File.expand_path('../../', __FILE__)

ENV['RACK_ENV'] = 'test'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'
require 'app'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

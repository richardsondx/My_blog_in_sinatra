require 'rubygems'
require 'sinatra'

get '/' do
    "Hello"
end

unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'config'
require_relative 'routes'

# class MyApp < Sinatra::Base
#   get '/' do
#     'Hello world!'
#   end
# end
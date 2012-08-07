require 'rubygems'
require 'sinatra'

class App < Sinatra::Base

run! if app_file == $0

unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'config'
require_relative 'routes'

end

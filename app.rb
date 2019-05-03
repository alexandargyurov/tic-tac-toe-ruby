require 'rack'
require 'erb'

require_relative "./lib/tic_tac_toe.rb"


class Application
  def initialize
    @template = File.read("./public/index.html.erb")
    @board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
  end

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)


    if req.params['play']
      play = req.params['play']
      turn(@board, play)
    elsif req.params['reset']
      @board = ["_", "_", "_", "_", "_", "_", "_", "_", "_"]
      @winner = nil
      @draw = nil
    end

    res.write ERB.new(@template).result(binding)
    res.finish
  end
end
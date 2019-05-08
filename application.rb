require_relative './lib/tic_tac_toe'
require 'rack'
require "securerandom"
require 'erb'
require "pry"


class Application

  @@all_sessions = []

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    template = File.read('/Users/alexgyurov/Development/tic-tac-toe-server/public/index.html.erb')

    if req.params['game'] && req.params['play']
      play = req.params['play']
      game = find_game(req.params['game'])
      game.turn(play)
    end

    if req.params['new_game']
      new_game = TicTacToe.new()
      req.session['game_session'] = new_game
      res.redirect("?game=#{new_game.__id__}")
      res.write ERB.new(template).result(binding)
      res.finish
    end

    if req.params['join']
      res.write ERB.new(template).result(binding)
      res.finish
    end

    if req.params['reset']
      req.session['game_session'] = TicTacToe.new()
    end

    if req.params['join_game']
      find_game
    end

    res.write ERB.new(template).result(binding)
    res.finish
  end

  def get_game(req)
    currect_game = find_game(req.params['game'])
    currect_game
  end

  def get_winner(req)
    currect_game = find_game(req.params['game'])
    currect_game.winner
  end

  def find_game(params)
    TicTacToe.games.each do |game|
      if game.__id__ == params.to_i
        return game
      else
        'error'  # TODO: No error page on frontend
      end
    end
  end

end
require_relative 'game'
require_relative 'player'
require_relative 'hand'
require_relative 'deck'
require_relative 'card'

puts "Welcome to Epic Poker!"
puts "How many players? (2-4):"

number_of_players = gets.chomp.to_i
until (2..4).cover?(number_of_players)
  puts "Please enter a number between 2 and 4:"
  number_of_players = gets.chomp.to_i
end

player_names = []
number_of_players.times do |num|
  print "Enter player #{num + 1} name: "
  name = gets.chomp
  player_names << name
end

starting_pot = 1000
game = Game.new(player_names, starting_pot)
game.play

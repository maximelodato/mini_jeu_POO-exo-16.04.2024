require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "Voici l'état de chaque joueur :"
player1.show_state
player2.show_state

puts "Passons au combat !"

while player1.life_points > 0 && player2.life_points > 0
  puts "\nRound suivant :"
  player1.attacks(player2)
  break if player2.life_points <= 0

  player2.attacks(player1)
  break if player1.life_points <= 0
end

puts "\nLe combat est terminé !"

if player1.life_points <= 0
  puts "Josiane est vaincu YOU ARE THE BEST !"
elsif player2.life_points <= 0
  puts "José est vaincu YOU ARE THE BEST !"
end




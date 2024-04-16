require 'bundler'
Bundler.require
require_relative 'lib/game'
require_relative 'lib/player'


puts "------------------------------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !    |"
puts "| Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Quel est ton prénom ?"
print "> "
player_name = gets.chomp

my_game = Game.new(player_name)

while my_game.is_still_ongoing?

  my_game.show_players

  
  my_game.menu

 
  puts "\n>"
  action = gets.chomp

  
  my_game.menu_choice(action)

  
  puts "Les autres joueurs t'attaquent !"
  my_game.enemies_attack
end


my_game.game_end

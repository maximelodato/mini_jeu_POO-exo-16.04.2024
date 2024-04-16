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
human_player = HumanPlayer.new(player_name)
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

def menu(player1, player2) 
    puts "\nQuelle action veux-tu effectuer ?"
    puts "a - cherche une meilleure arme connard :"
    puts "s - cherche à te soigner petite fille :"
    puts "attaquer un joueur :"
    puts "0 - Josiane a #{player1.life_points} points de vie"
    puts "1 - José a #{player2.life_points} points de vie"
   end

   def option_choice(action, player1, player2, human_player)
     case action
   when "a"
     human_player.search_weapon
   when "s"
     human_player.search_health_pack
   when "0"
       human_player.attacks(player1)
   when "1"
       human_player.attacks(player2)
     return false
   else
    put "choix invalide"
   end
   return true
end

while human_player.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
   
    puts "\n#{human_player.name}, voici ton état :"
    human_player.show_state
    menu(player1, player2)
    print "choisie une action"
  
    puts "\n>"
    action = gets.chomp
    
    break unless option_choice(action, player1, player2, human_player)
    puts "Les autres joueurs t'attaquent ! ca sent le gang bang "
    enemies.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(human_player)
        next if human_player.life_points <= 0
      end
    end
end

 puts "fin de partie"
 if human_player.life_points > 0 
    puts "you win"
else 
 puts "you lose"
end


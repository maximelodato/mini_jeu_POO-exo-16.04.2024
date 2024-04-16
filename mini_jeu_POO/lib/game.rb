require_relative 'player'

class Game
  attr_accessor :human_player, :players_left, :enemies_in_sight

  def initialize(player_name)
    @human_player = HumanPlayer.new(player_name)
    @players_left = 10
    @enemies_in_sight = [Player.new("Josiane"), Player.new("José")]
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
    @players_left -= 1
  end  

  def is_still_ongoing?
    @human_player.life_points > 0 && @enemies_in_sight.any?
  end
  
  def show_players
    puts "------------------------------------"
    @human_player.show_state
    puts "------------------------------------"
    puts "Il reste #{@players_left - 1} adversaires en vie."
    puts "------------------------------------"
  end

  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "------------------------------------"
    puts "attaquer un joueur en vue :" unless @enemies_in_sight.empty?
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
    end
    puts "------------------------------------"
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    else
      enemy_index = choice.to_i
      if (0...@enemies_in_sight.length).include?(enemy_index)
        target_enemy = @enemies_in_sight[enemy_index]
        puts "Attaque contre #{target_enemy.name} choisie."
        @human_player.attacks(target_enemy)
        if target_enemy.life_points <= 0
          kill_player(target_enemy)
          puts "#{target_enemy.name} a été tué."
        end
      else
        puts "Index d'ennemi invalide."
      end
    end
  end
  

  def enemies_attack
    @enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player) if enemy.life_points.positive?
    end
  end
  
  def new_players_in_sight
    total_enemies = @enemies_in_sight.length + 1  # Ajoute 1 pour inclure le joueur humain
    if total_enemies >= 10
      puts "Le maximum d'ennemis est déjà atteint."
    else
      dice_roll = rand(1..6)
      case dice_roll
      when 1
        puts "Aucun nouvel adversaire n'arrive."
      when 2..4
        new_enemy = Player.new("joueur_#{rand(1000..9999)}")
        @enemies_in_sight << new_enemy
        puts "#{new_enemy.name} arrive en vue !"
      when 5..6
        2.times do
          total_enemies += 1
          break if total_enemies >= 10
          new_enemy = Player.new("joueur_#{rand(1000..9999)}")
          @enemies_in_sight << new_enemy
          puts "#{new_enemy.name} arrive en vue !"
        end
      end

      unless @enemies_in_sight.any? { |enemy| enemy.name == "José" }
        jose = Player.new("José")
        @enemies_in_sight << jose
        puts "José arrive en vue !"
      end
    end
  end

  
  def game_end
    puts "------------------------------------"
    puts "La partie est finie."
    if @human_player.life_points > 0
      puts "Bravo ! Tu as gagné !"
    else
      puts "Loser ! Tu as perdu !"
    end
    puts "------------------------------------"
  end   
end

puts "Bienvenue dans le jeu ! Quel est votre pseudo ?"
pseudo = gets.chomp

my_game = Game.new(pseudo)

while my_game.is_still_ongoing?
  my_game.show_players
  my_game.menu
  action = gets.chomp
  my_game.menu_choice(action)
  my_game.new_players_in_sight 
  my_game.enemies_attack  
end

my_game.game_end

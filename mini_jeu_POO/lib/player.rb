require "pry"

class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage)
    @life_points -= damage
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
      @life_points = 0
    else
      puts "#{@name} perd #{damage} points de vie."
      puts "#{@name} a #{@life_points} points de vie restants."
    end
  end

  def attacks(other_player)
    damage = compute_damage
    puts "#{@name} attaque #{other_player.name}"
    other_player.gets_damage(damage)
  end

  private

  def compute_damage
    rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts "Meilleur arme trouvé tu la prend 💕!! "
    else
      puts "M@*#$... jette cette arme de 💩..."
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts "y'a whelou frere !... 😢"
    elsif dice >= 2 && dice <= 5
      puts "Bravo, tu as trouvé +50 points de vie c'est ta tournée !"
      @life_points = [@life_points + 50, 100].min
    else
      puts "Waow, tu as trouvé un pack de +80 points de vie meilleur souvenir de ta vie !"
      @life_points = [@life_points + 80, 100].min
    end
  end
end

player1 = Player.new("Alice")
player1.show_state
player1.gets_damage(5)

binding.pry

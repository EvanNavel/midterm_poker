class Player
  attr_accessor :hand, :pot
  attr_reader :name, :folded

  def initialize(name, starting_pot)
    @name = name
    @pot = starting_pot
    @hand = Hand.new
    @folded = false
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def bet(amount)
    raise "Insufficient funds" if amount > @pot
    @pot -= amount
    amount
  end

  def call(amount)
    bet(amount)
  end

  def raise_bet(current_bet, additional_amount)
    call(current_bet) + bet(additional_amount)
  end

  def add_to_pot(amount)
    @pot += amount
  end

  def take_card(card)
    @hand.add_card(card)
  end

  def toss_card(card)
    @hand.remove_card(card)
  end
end

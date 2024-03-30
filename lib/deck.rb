class Deck
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  attr_reader :cards

  def initialize
    @cards = SUITS.product(RANKS).map do |suit, rank|
      Card.new(suit, rank)
    end
    shuffle
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end

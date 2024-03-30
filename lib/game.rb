require_relative 'deck'
require_relative 'player'
require_relative 'hand'
require_relative 'card'

class Game
  attr_reader :players, :deck, :current_bet, :pot

  def initialize(player_names, starting_pot)
    @deck = Deck.new
    @players = player_names.map { |name| Player.new(name, starting_pot) }
    @current_bet = 0
    @pot = 0
    @round = 0
  end

  def deal_cards
    players.each { |player| player.hand.cards = deck.deal(5) }
  end

  def take_bets
    players.each do |player|
      bet_amount = player.decide_bet(current_bet)
      if bet_amount >= current_bet
        player.bet(bet_amount)
        @pot += bet_amount
        @current_bet = bet_amount if bet_amount > current_bet
      else
        player.fold
      end
    end
  end

  def round_of_play
    deal_cards
    take_bets
    # additional round logic
  end

  def determine_winner
    players.reject(&:folded).max_by { |player| player.hand.rank_value }
  end

  def next_round
    @deck = Deck.new
    @current_bet = 0
    @pot = 0
    players.each { |player| player.unfold; player.hand.cards.clear }
    @round += 1
  end

  def play
    round_of_play
    winner = determine_winner
    # end of round logic
    next_round
  end
end

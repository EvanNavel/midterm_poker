require_relative 'deck'
require_relative 'player'
require_relative 'hand'
require_relative 'card'

class Game
  attr_reader :players, :deck, :current_bet, :pot

  def initialize(player_names, starting_pot)
    @deck = Deck.new
    @deck.shuffle
    @players = player_names.map { |name| Player.new(name, starting_pot) }
    @current_bet = 0
    @pot = 0
    @round = 0
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def show_hand(player)
    clear_screen
    puts "Player #{player.name}, press Enter when you are ready to see your hand."
    gets
    player.show_hand
    puts "Press Enter when you are done looking at your hand and ready to bet or fold."
    gets
    clear_screen
  end

  def deal_cards
    @deck.shuffle
    if @deck.is_a?(Deck) && @deck.cards.length >= 5 * players.length
      players.each do |player|
        player.hand = Hand.new(@deck.deal(5))
      end
    else
      puts "Not enough cards in the deck to deal."
    end
  end

  def take_bets
    players.each do |player|
      next if player.folded?
      show_hand(player)
      puts "#{player.name}, you have #{player.pot}. Press 'F' to fold or 'B' to bet:"
      action = gets.chomp.upcase

      if action == 'F'
        player.fold
        puts "#{player.name} has folded."
        next
      elsif action == 'B'
        puts "How much do you want to bet?"
        bet_amount = gets.to_i
        if bet_amount >= @current_bet && bet_amount <= player.pot
          @pot += player.bet(bet_amount)
          @current_bet = bet_amount if bet_amount > @current_bet
        else
          puts "Bet amount is more than available pot." if bet_amount > player.pot
          player.fold
        end
      else
        puts "Invalid input. Please enter 'F' to fold or 'B' to bet."
        redo
      end
    end
  end

  def determine_winner
    players.reject(&:folded?).max_by { |player| player.hand.rank_value }
  end

  def distribute_winnings(winner)
    puts "#{winner.name} wins the pot of #{@pot}"
    winner.add_to_pot(@pot)
    @pot = 0
  end

  def reset_for_next_round
    puts "Resetting deck for the next round..."
    @deck = Deck.new
    @deck.shuffle
    @current_bet = 0
    @pot = 0
    players.each(&:prepare_for_new_round)
  end

  def play_round
    reset_for_next_round
    deal_cards
    take_bets
    winner = determine_winner
    distribute_winnings(winner)
  end

  def play
    while @round < 5
      play_round
      @round += 1
    end
    puts "Thanks for playing Epic Poker!"
  end
end

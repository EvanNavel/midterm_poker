require_relative 'deck'
require_relative 'player'
require_relative 'hand'
require_relative 'card'

class Game
  attr_reader :players, :deck, :current_bet, :pot

  def initialize(player_names, starting_pot)
    @deck = Deck.new
    @deck.shuffle
    @players = player_names.map { |name| Player.new(name, starting_pot) }.shuffle
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
      puts "#{player.name}, the current bet to match is #{@current_bet}."
      puts "You have #{player.pot}. Press 'F' to fold, 'C' to call, or 'R' to raise:"
      action = gets.chomp.upcase

      case action
      when 'F'
        player.fold
        puts "#{player.name} has folded."
      when 'C'
        if player.pot >= @current_bet
          @pot += player.bet(@current_bet)
        else
          puts "Insufficient funds to call. You must fold."
          player.fold
        end
      when 'R'
        puts "How much do you want to raise by?"
        raise_amount = gets.to_i
        total_bet = @current_bet + raise_amount
        if total_bet <= player.pot
          @pot += player.bet(total_bet)
          @current_bet = total_bet
        else
          puts "Insufficient funds to raise. You must fold or call."
        end
      else
        puts "Invalid input. Please enter 'F' to fold, 'C' to call, or 'R' to raise."
        redo
      end
    end
  end

  def determine_winner
    winning_player = players.reject(&:folded?).max_by { |player| player.hand.rank_value }
    if winning_player
      puts "#{winning_player.name} has the winning hand."
    else
      puts "No winner this round as all players have folded."
    end
    winning_player
  end

  def distribute_winnings(winner)
    if winner
      puts "#{winner.name} wins the pot of #{@pot}"
      winner.add_to_pot(@pot)
    else
      puts "No winner this round."
    end
    @pot = 0
    puts "Press Enter to continue to the next round."
    gets
  end

  def reset_for_next_round
    puts "Resetting deck for the next round..."
    @deck = Deck.new
    @deck.shuffle
    @players.shuffle!
    @current_bet = 0
    players.each(&:prepare_for_new_round)
    clear_screen
  end

  def play_round
    reset_for_next_round
    deal_cards
    take_bets
    winner = determine_winner
    distribute_winnings(winner) if winner
    puts "Press Enter to continue to the next round."
    gets
  end

  def play
    while @round < 5
      play_round
      @round += 1
    end
    puts "Thanks for playing Epic Poker!"
  end
end

class Game
  attr_reader :players, :deck, :current_bet, :pot

  def initialize(player_names, starting_pot)
    @deck = Deck.new.shuffle
    @players = player_names.map { |name| Player.new(name, starting_pot) }
    @current_bet = 0
    @pot = 0
    @round = 0
  end

  def deal_cards
    if @deck.is_a?(Deck) && @deck.cards.length >= 5
      players.each { |player| player.hand = Hand.new(@deck.deal(5)) }
    else
      puts "Not enough cards in the deck to deal."
    end
  end

  def take_bets
    players.each do |player|
      next if player.folded?
      puts "#{player.name}, you have #{player.pot}. How much do you want to bet?"
      bet_amount = gets.to_i
      if bet_amount >= @current_bet && bet_amount <= player.pot
        @pot += player.bet(bet_amount)
        @current_bet = bet_amount if bet_amount > @current_bet
      else
        puts "#{player.name} has folded." if bet_amount < @current_bet
        puts "Bet amount is more than available pot." if bet_amount > player.pot
        player.fold
      end
    end
  end

  def round_of_play
    deal_cards
    take_bets
  end

  def determine_winner
    players.reject(&:folded?).max_by { |player| player.hand.rank_value }
  end

  def distribute_winnings(winner)
    puts "#{winner.name} wins the pot of #{@pot}"
    winner.add_to_pot(@pot)
    @pot = 0
  end

  def play_round
    round_of_play
    winner = determine_winner
    distribute_winnings(winner)
  end

  def reset_for_next_round
    @deck = Deck.new.shuffle
    @current_bet = 0
    players.each(&:prepare_for_new_round)
  end

  def play
    while @round < 5
      play_round
      @round += 1
      reset_for_next_round
    end
    puts "Thanks for playing Epic Poker!"
  end
end

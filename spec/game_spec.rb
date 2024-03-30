require_relative '../lib/game'

RSpec.describe Game do
  let(:game) { Game.new(['Alice', 'Bob'], 100) }

  describe '#initialize' do
    it 'creates a game with two players' do
      expect(game.players.length).to eq(2)
    end

    it 'starts the game with an empty pot' do
      expect(game.pot).to eq(0)
    end

    it 'sets the current bet to zero' do
      expect(game.current_bet).to eq(0)
    end
  end

  describe '#deal_cards' do
    it 'deals five cards to each player' do
      expect(game.deck).to receive(:deal).with(5).twice.and_return(['card']*5)
      game.deal_cards
      expect(game.players.first.hand.cards.length).to eq(5)
      expect(game.players.last.hand.cards.length).to eq(5)
    end
  end

  describe '#determine_winner' do
    it 'finds the player with the best hand' do
      allow_any_instance_of(Hand).to receive(:evaluate_hand).and_return(['High Card', 1], ['Pair', 2])
      winner = game.determine_winner
      expect(winner).to eq(game.players.last)
    end
  end

  describe '#reset_for_next_round' do
    it 'resets the game for a new round' do
      expect(game.deck).to receive(:shuffle)
      game.reset_for_next_round
      expect(game.current_bet).to eq(0)
      expect(game.pot).to eq(0)
      game.players.each do |player|
        expect(player).to receive(:prepare_for_new_round)
      end
    end
  end
end

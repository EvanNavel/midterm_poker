
require_relative '../lib/player'
require_relative '../lib/hand'

RSpec.describe Player do
  let(:player) { Player.new("Snoop Dogg", 420) }

  describe '#take_card and #toss_card' do
    let(:card) { double('Card') }

    it 'adds a card to the player\'s hand' do
      expect { player.take_card(card) }.to change { player.hand.cards.length }.by(1)
    end

    it 'removes a card from the player\'s hand' do
      player.take_card(card)
      expect { player.toss_card(card) }.to change { player.hand.cards.length }.by(-1)
    end
  end

  describe '#prepare_for_new_round' do
    before do
      player.fold
      player.prepare_for_new_round
    end

    it 'resets the hand' do
      expect(player.hand.cards).to be_empty
    end

    it 'unfolds the player' do
      expect(player.folded).to be false
    end
  end
end

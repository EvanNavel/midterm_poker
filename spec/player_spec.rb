require_relative '../lib/player'
require_relative '../lib/card'
require_relative '../lib/hand'

RSpec.describe Player do
  let(:player) { Player.new("Snoop Dogg", 420) }
  let(:card) { Card.new('Clubs', '5') }

  describe '#initialize' do
    it 'creates a player with a name and pot' do
      expect(player.name).to eq("Snoop Dogg")
      expect(player.pot).to eq(420)
    end

    it 'starts with an empty hand' do
      expect(player.hand.cards).to be_empty
    end
  end

  describe '#fold' do
    it 'sets the player as folded' do
      player.fold
      expect(player.folded).to be true
    end
  end

  describe '#unfold' do
    it 'sets the player as not folded' do
      player.unfold
      expect(player.folded).to be false
    end
  end

  describe '#bet' do
    context 'when the bet is in the pot limit' do
      it 'reduces the pot by the bet ' do
        expect { player.bet(100) }.to change { player.pot }.by(-100)
      end
    end

    context 'when the bet exceeds the pot limit' do
      it 'raises an error' do
        expect { player.bet(2000) }.to raise_error(RuntimeError, "Insufficient funds")
      end
    end
  end

  describe '#add_to_pot' do
    it 'increases the pot by the amount' do
      expect { player.add_to_pot(100) }.to change { player.pot }.by(100)
    end
  end

  describe '#take_card' do
    it 'gives a card to the player' do
      player.take_card(card)
      expect(player.hand.cards).to include(card)
    end
  end

  describe '#toss_card' do
    it 'removes a card from the player' do
      player.take_card(card)
      expect { player.toss_card(card) }.to change { player.hand.cards.length }.by(-1)
    end
  end
end

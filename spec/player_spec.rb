require_relative '../lib/player'
require_relative '../lib/card'
require_relative '../lib/hand'

RSpec.describe 'Class initialization' do
  describe 'Card class' do
    it 'initializes without error' do
      expect { Card.new('Hearts', 'Ace') }.not_to raise_error
    end
  end

  describe 'Hand class' do
    it 'initializes without error' do
      expect { Hand.new([]) }.not_to raise_error
    end
  end
end

RSpec.describe Player do
  let(:player) { Player.new("Snoop Dogg", 420) }
  let(:card) { Card.new('Clubs', '5') }

  describe '#initialize' do
    it 'correctly assigns name and pot' do
      expect(player.name).to eq("Snoop Dogg")
      expect(player.pot).to eq(420)
    end

    it 'initializes with an empty hand' do
      expect(player.hand.cards).to be_empty
    end

    it 'initializes as not folded' do
      expect(player.folded).to be(false)
    end
  end

  describe '#fold' do
    it 'marks the player as folded' do
      player.fold
      expect(player.folded).to be true
    end
  end

  describe '#unfold' do
    it 'marks the player as not folded' do
      player.fold
      player.unfold
      expect(player.folded).to be false
    end
  end

  describe '#bet' do
    context 'when the bet is within the pot limit' do
      it 'reduces the pot by the bet amount' do
        expect { player.bet(100) }.to change { player.pot }.by(-100)
      end
    end

    context 'when the bet exceeds the pot limit' do
      it 'raises an error' do
        expect { player.bet(500) }.to raise_error(RuntimeError, "Insufficient funds")
      end
    end
  end

  describe '#raise_bet' do
    it 'correctly raises the bet' do
      current_bet = 50
      raise_amount = 100
      expect { player.raise_bet(current_bet, raise_amount) }.to change { player.pot }.from(420).to(270)
    end
  end

  describe '#add_to_pot' do
    it 'increases the pot by the specified amount' do
      expect { player.add_to_pot(80) }.to change { player.pot }.by(80)
    end
  end

  describe '#take_card' do
    it 'adds a card to the player\'s hand' do
      player.take_card(card)
      expect(player.hand.cards).to include(card)
    end
  end

  describe '#toss_card' do
    before { player.take_card(card) }

    it 'removes a card from the player\'s hand' do
      expect { player.toss_card(card) }.to change { player.hand.cards.count }.from(1).to(0)
    end
  end
end

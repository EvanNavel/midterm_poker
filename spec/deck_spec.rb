require_relative '../lib/deck'
require_relative '../lib/card'

RSpec.describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'creates a deck with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
  end

  describe '#shuffle' do
    it 'shuffles the deck' do
      original_deck = deck.cards.dup
      deck.shuffle
      expect(deck.cards).not_to eq(original_deck)
    end
  end

  describe '#deal' do
    it 'deals a specified number of cards from the deck' do
      expect { deck.deal(5) }.to change(deck.cards, :count).by(-5)
    end

    it 'returns the number of cards' do
      expect(deck.deal(5).count).to eq(5)
    end

    it 'returns an array of cards' do
      expect(deck.deal(5)).to all(be_an_instance_of(Card))
    end
  end
end

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

  describe '#deal_card' do
    it 'removes a card from the deck' do
      expect { deck.deal_card }.to change(deck.cards, :count).by(-1)
    end

    it 'returns a random card' do
      expect(deck.deal_card).to be_an_instance_of(Card)
    end
  end
end

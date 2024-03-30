require_relative '../lib/hand'
require_relative '../lib/card'

RSpec.describe Hand do
  describe '#evaluate_hand' do
    context 'when hand is a Straight Flush' do
      it 'returns Straight Flush with correct rank value' do
        cards = [
          Card.new('Hearts', '6'),
          Card.new('Hearts', '7'),
          Card.new('Hearts', '8'),
          Card.new('Hearts', '9'),
          Card.new('Hearts', '10')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['Straight Flush', 9])
      end
    end

    context 'when hand is Four of a Kind' do
      it 'returns Four of a Kind with correct rank value' do
        cards = [
          Card.new('Diamonds', '9'),
          Card.new('Hearts', '9'),
          Card.new('Clubs', '9'),
          Card.new('Spades', '9'),
          Card.new('Hearts', '3')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['Four of a Kind', 8])
      end
    end

    context 'when hand is a Full House' do
      it 'returns Full House with correct rank value' do
        cards = [
          Card.new('Diamonds', '10'),
          Card.new('Hearts', '10'),
          Card.new('Clubs', '10'),
          Card.new('Spades', '7'),
          Card.new('Hearts', '7')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['Full House', 7])
      end
    end

    context 'when hand is a Flush' do
      it 'returns Flush with correct rank value' do
        cards = [
          Card.new('Hearts', '2'),
          Card.new('Hearts', '5'),
          Card.new('Hearts', '9'),
          Card.new('Hearts', 'Jack'),
          Card.new('Hearts', 'King')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['Flush', 6])
      end
    end

    context 'when hand is a Straight' do
      it 'returns Straight with correct rank value' do
        cards = [
          Card.new('Hearts', '10'),
          Card.new('Clubs', 'Jack'),
          Card.new('Diamonds', 'Queen'),
          Card.new('Spades', 'King'),
          Card.new('Hearts', 'Ace')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['Straight', 5])
      end
    end

    context 'when hand is High Card' do
      it 'returns High Card with correct rank value' do
        cards = [
          Card.new('Diamonds', '2'),
          Card.new('Hearts', '4'),
          Card.new('Clubs', '6'),
          Card.new('Spades', '8'),
          Card.new('Hearts', 'Jack')
        ]
        hand = Hand.new(cards)
        expect(hand.evaluate_hand).to eq(['High Card', 1])
      end
    end
  end
end

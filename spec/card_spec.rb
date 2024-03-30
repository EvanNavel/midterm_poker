require_relative '../lib/card.rb'

RSpec.describe Card do
  describe 'initialization' do
    let(:card) { Card.new('Hearts', '2') }

    it 'has a suit' do
      expect(card.suit).to eq('Hearts')
    end

    it 'has a rank' do
      expect(card.rank).to eq('2')
    end
  end

  describe '#to_s' do
    let(:card) { Card.new('Hearts', 'Queen') }

    it 'returns the full card name' do
      expect(card.to_s).to eq('Queen of Hearts')
    end
  end
end

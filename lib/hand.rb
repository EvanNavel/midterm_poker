class Hand
  include Comparable

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def <=>(other)
    rank_value <=> other.rank_value
  end

  def evaluate_hand
    if royal_flush?
      ['Royal Flush', 10]
    elsif straight_flush?
      ['Straight Flush', 9]
    elsif four_of_a_kind?
      ['Four of a Kind', 8]
    elsif full_house?
      ['Full House', 7]
    elsif flush?
      ['Flush', 6]
    elsif straight?
      ['Straight', 5]
    elsif three_of_a_kind?
      ['Three of a Kind', 4]
    elsif two_pair?
      ['Two Pair', 3]
    elsif one_pair?
      ['One Pair', 2]
    else
      ['High Card', 1]
    end
  end

  def card_value(rank)
    case rank
    when 'Ace' then 14
    when 'King' then 13
    when 'Queen' then 12
    when 'Jack' then 11
    else rank.to_i
    end
  end
end

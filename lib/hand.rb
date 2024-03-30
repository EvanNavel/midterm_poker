class Hand
  include Comparable

  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def <=>(other)
    rank_value <=> other.rank_value
  end

  def rank_value
    evaluate_hand.last
  end

  def add_card(card)
    @cards << card
  end

  def remove_card(card)
    @cards.delete(card)
  end

  def ranks
    @cards.map(&:rank)
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

  private

  def royal_flush?
    straight_flush? && @cards.any? { |card| card.rank == 'Ace' }
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    ranks.any? { |rank| ranks.count(rank) == 4 }
  end

  def full_house?
    ranks.uniq.length == 2 && ranks.any? { |rank| ranks.count(rank) == 3 }
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def straight?
    sorted_ranks = @cards.map { |card| card_value(card.rank) }.sort
    sorted_ranks.each_cons(2).all? { |x, y| y == x + 1 }
  end

  def three_of_a_kind?
    ranks.any? { |rank| ranks.count(rank) == 3 }
  end

  def two_pair?
    ranks.uniq.length == 3 && ranks.uniq.any? { |rank| ranks.count(rank) == 2 }
  end

  def one_pair?
    ranks.uniq.length == 4
  end
end

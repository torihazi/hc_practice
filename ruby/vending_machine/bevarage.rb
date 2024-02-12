# frozen_string_literal: true

# クラス名 Bevarage
# @param [String] name 名前
# @param [Integer] price 値段
class Bevarage
  def initialize(name, price)
    @name = name
    @price = price
  end

  def name
    @name
  end

  def price
    @price
  end
end

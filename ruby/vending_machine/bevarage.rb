# frozen_string_literal: true

# クラス名 Bevarage
# @param [String] name 名前
# @param [Integer] price 値段
class Bevarage
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

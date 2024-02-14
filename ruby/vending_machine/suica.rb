# frozen_string_literal: true

# クラス名 Suica
# @param [Integer] balance 残高
# @param [Integer] money 入出金額
class Suica
  attr_reader :balance
  attr_writer :balance

  INIT_DEPOSIT = 500
  MIN_CHARGE = 100

  def initialize(balance = INIT_DEPOSIT)
    @balance = balance
  end

  def top_up(money)
    if money >= MIN_CHARGE
      @balance += money
    else
      raise 'チャージは100円以上から可能です。'
    end
  end
end

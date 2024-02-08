# frozen_string_literal: true

# クラス名 Golf
# @param [Integer] par 規定打数
# @param [Integer] stroke 自身の打数
class Golf
  def initialize(par, stroke)
    @par = par
    @stroke = stroke
  end

  # 1ホールごとにparとstrokeからスコアを出力する
  def score_check
    @score = @stroke - @par

    if @score == 1
      'ボギー'
    elsif @score >= 2
      "#{@score}ボギー"
    elsif @score.zero?
      'パー'
    elsif @score == -1
      'バーディ'
    elsif @score == -2 && @stroke != 1
      'イーグル'
    elsif @score == -3 && @stroke != 1
      'アルバトラス'
    elsif @score == -4
      'コンドル'
    elsif @stroke == 1
      'ホールインワン'
    end
  end
end

lines = []
while (line = gets)
  lines << line.chomp.split(',').map(&:to_i)
end

golfs = []
lines[0].zip(lines[1]) do |v|
  golfs << Golf.new(v[0], v[1]).score_check
end
puts golfs.join(',')

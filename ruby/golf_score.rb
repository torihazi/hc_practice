# frozen_string_literal: true

# クラス名 Golf
# @param [Integer] par 規定打数
# @param [Integer] stroke 自身の打数
class Golf
  SCORE_MAPPING = {
    -4 => 'コンドル',
    -3 => 'アルバトロス',
    -2 => 'イーグル',
    -1 => 'バーディ',
    0 => 'パー',
    1 => 'ボギー'
  }.freeze

  def initialize(par, stroke)
    @par = par
    @stroke = stroke
  end

  # 1ホールごとにparとstrokeからスコアを出力する
  def score_check
    @score = @stroke - @par

    if @stroke == 1 && @par != 5
      'ホールインワン'
    elsif @score >= 2
      "#{@score}ボギー"
    else
      SCORE_MAPPING[@score]
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

# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new

options = { month: Date.today.month }

# 引数の受け取り
opt.on('-m [month]', Integer) do |month|
  if month >= 1 && month <= 12
    options[:month] = month
  else
    puts "#{month} is neither a month number (1..12) nor a name"
    exit
  end
end

begin
  opt.parse!(ARGV)
rescue NoMethodError
  puts 'Only integers between 1 and 12'
  exit
end

# データの用意
year = Date.today.year
header = Date.new(year, options[:month]).strftime('%-m月 %Y')
start_day = Date.new(year, options[:month], 1)
end_day = Date.new(year, options[:month], -1)
wdays = %w[月 火 水 木 金 土 日]
wday = start_day.wday

# カレンダー出力
puts header.center(20)
puts wdays.join(' ')
print '   ' * (start_day.wday - 1)

(1..end_day.day).each do |date|
  print format('%2s', date.to_s)
  print ' '
  puts '' if (wday % 7).zero?
  wday += 1
end

puts

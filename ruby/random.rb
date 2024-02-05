# frozen_string_literal: true

array = ('A'..'F').to_a
num = rand(2..4)
a = array.sample(num)
b = array - a
p a.sort, b.sort

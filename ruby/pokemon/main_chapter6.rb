require_relative 'chapter6'

def main
    pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    pika.changeName('テキセツ')
    puts pika.name
    pika.changeName('うんこ')
    puts pika.name
end

main

poke = Pikachu.new('ピカチュウ', 'でんき', '', 100)
poke.name = 'hoge'
puts poke.name
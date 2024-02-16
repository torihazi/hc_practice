require_relative 'chapter4'

def main
    pika = Pikachu.new('ピカチュウ', 'でんき', '', 100)
    puts pika.name
    puts pika.attack
end

main

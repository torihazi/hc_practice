require_relative 'chapter3'

def main
    poke = Pokemon.new('ピカチュウ', 'でんき', '', 100 )
    puts poke.name
end

main
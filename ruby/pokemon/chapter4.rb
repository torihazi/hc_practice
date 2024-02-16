class Pokemon
    attr_reader :name

    def initialize(name, type1, type2, hp) 
        @name = name
        @type1 = type1
        @type2 = type2
        @hp = hp
    end

    def attack
        "#{@name}のこうげき!"
    end
end

class Pikachu < Pokemon

    def attack
        "#{@name}の10万ボルト!"
    end
end

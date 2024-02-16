class Pokemon
    attr_reader :name

    def initialize(name, type1, type2, hp) 
        @name = name
        @type1 = type1
        @type2 = type2
        @hp = hp
    end
end

class Pikachu < Pokemon

    def initialize(name, type1, type2, hp)
        super(name, type1, type2, hp)
    end

    def attack()
        "#{@name}の10万ボルト!"
    end
end
